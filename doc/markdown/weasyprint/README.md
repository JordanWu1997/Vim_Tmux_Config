# README

## Installation

```sh
apt install Weasyprint
  apt install fonts-noto-cjk
```

## Usage: Convert Markdown to PDF

```sh
pandoc -f markdown -d document.yaml -o <OUTPUT_PDF> <INPUT_MARKDOWN>
```

### Example

```sh
pandoc -f markdown -d document.yaml -o example.pdf example.md
```

## Usage: Convert Markdown -> HTML -> DOCX

### Requirement:

- Libreoffice to convert HTML to docx

### Usage

```sh
pandoc <INPUT_MARKDOWN> -o <OUTPUT_HTML> -d document.yaml -s
      soffice --headless \
                  --infilter="HTML (StarWriter)" \
                  --convert-to "docx:MS Word 2007 XML" \
                  <OUTPUT_HTML>
```

### Example

```sh
pandoc example.md -o example.html -d document.yaml -s
      soffice --headless \
                  --infilter="HTML (StarWriter)" \
                  --convert-to "docx:MS Word 2007 XML" \
                  example.html
```
