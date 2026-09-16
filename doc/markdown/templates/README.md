# README

## Installation

```sh
# Clones repo to /tmp and copies templates to ~/.pandoc/templates
curl 'https://raw.githubusercontent.com/ryangrose/easy-pandoc-templates/master/copy_templates.sh' | bash
```

## Usage

```sh
pandoc -f markdown -t html --data-dir=$HOME/.pandoc --template=bootstrap_menu.html --metadata=title:%:t:r --toc -o <OUTPUT_HTML> <INPUT_MARKDOWN>
```
