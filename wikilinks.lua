function Str (elem)
    if elem.text:match("%[%[.*]]") then
        local filetype = ""

        -- get contents between "[[" and "]]"
        local substring = string.sub(elem.text, 3, string.len(elem.text) - 2)

        -- get title, filename and header link if presented: title|file-name#header-link
        local filename = ""
        local header = ""
        local title = ""
        local pipe_index = string.find(substring, "|")
        local sharp_index = string.find(substring, "#")
        if pipe_index and sharp_index then
            title = string.sub(substring, 1, pipe_index - 1)
            filename = string.sub(substring, pipe_index + 1, sharp_index - 1)
            header = string.sub(substring, sharp_index, string.len(substring))
        elseif pipe_index and not sharp_index then
            title = string.sub(substring, 1, pipe_index - 1)
            filename = string.sub(substring, pipe_index + 1, string.len(substring))
        elseif not pipe_index and sharp_index then
            filename = string.sub(substring, 1, sharp_index - 1)
            header = string.sub(substring, sharp_index, string.len(substring))
        else
            filename = substring
        end

        -- get file title from file metadata
        local file = io.open(filename .. ".md", "r")
        if not file then
            if string.len(title) == 0 then
                title = substring
            end
            filetype = ""
        else
            local content = file:read "*a"
            file:close()
            local document = pandoc.read(content, "markdown")
            if string.len(title) == 0 then
                title = document.meta.title
            end
            filetype = ".md"
        end

        -- substitute wikilink
        return pandoc.Link(title, filename .. filetype .. header)
    else
        return elem
    end
end