# pandoc-wikilinks

A lua filter script for [Pandoc](https://pandoc.org/) allowing wikilinks parsing (Markdown).

## Usage

E.g. project structure is:

```
project
|- articles
|  |- main.md
|  |- target.md
```

When you can use wikilinks syntax inside Markdown files with the following format: `custom name|target-file#target-paragraph`, where `custom name|` is optional custom link title, `target-file` is optional target file (if not specified, the current file is used), `#target-paragraph` is optional paragraph.

> By default it will use `title` in `target.md` file's front matter as link name.

For example, in `main.md` file:

```md
[[target]]

[[target#paragraph-1]]

[[Another name|target]]

[[Another paragraph 2 name|target#paragraph-2]]

[[#paragraph-inside-main]]

[[Another main paragraph name|#paragraph-inside-main]]
```

Before compiling, you need to know path of `wikilinks.lua`. For convinience let's assume that path of it's parent directory is `${PATH_TO_SCRIPT_DIR}`. It depends on [installation method](#installation). If script installed as [project dependency](#as-project-dependency) (without changing subproject directory path), this path by default is `${PROJECT_ROOT}/pandoc-wikilinks`.

```sh
pandoc -f markdown -t html -o main.html --lua-filter=${PATH_TO_SCRIPT_DIR}/wikilinks.lua main.md
```

### Markdown Preview Enhanced

If you are using [Markdown Preview Enhanced](https://marketplace.visualstudio.com/items?itemName=shd101wyy.markdown-preview-enhanced) extension for [Visual Studio Code](https://code.visualstudio.com/) with Pandoc, you can add the following configuration in `settings.json` (don't forget to substitute corresponding `${PATH_TO_SCRIPT_DIR}`):

```json
    "markdown-preview-enhanced.usePandocParser": true,
    "markdown-preview-enhanced.pandocArguments": [
        "--lua-filter=${PATH_TO_SCRIPT_DIR}/wikilinks.lua"
    ]
```

## Installation

### As Project Dependency

You can install this script into project as [git submodule](https://git-scm.com/book/en/v2/Git-Tools-Submodules).

```sh
git submodule add https://github.com/deverte/pandoc-wikilinks
```

### Standalone

Also you can use this script standalone, just clone this repository.

```sh
git clone https://github.com/deverte/pandoc-wikilinks
```

## License

[GPLv3](LICENSE)