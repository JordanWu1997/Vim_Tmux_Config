# Markdown writing w/ Pandoc

## Tasks

- [X] Citation in markdown and export with `pandoc`
- [X] Export Unicode document (Chinese) using pandoc yaml with `xelatex`
- [X] Export Unicode document keeping color html tag using pandoc yaml with `weasyprint`
  - Document Formats: PDF, DOCX
- [X] Presentation with `marp`
- [X] Export document with `pandoc` template
  - templates: https://github.com/ryangrose/easy-pandoc-templates
- [X] Export figures with `pandoc` (for now, `pandoc` can only export markdown syntax figures but not html tag)
- [X] Export mermaid diagram e.g. flowchart with `pandoc`

## Templates

- Book_Note_Template.md
- Manual_Template.md
- Markdown_Template.md
- Meeting_Template.md
- Note_Template.md
- Paper_Summary_Template.md

## Collection

### Citation

1. Add YAML Frontmatter

```yaml
---
bibliography: references.bib
---
```

2. Reference Biography File

```bib
@book{Russell2010,
  author = "Russell, Stuart J. and Norvig, Peter",
  title = "Artificial Intelligence: A Modern Approach",
  year = "2010",
  publisher = "Prentice Hall",
  address = "Upper Saddle River, NJ",
  edition = "3rd"
}
```

3. Citation Style File (`./citations/apa.csl`)

```sh
pandoc <INPUT_MARKDOWN> -o <OUTPUT_FILE> -f markdown --cite --csl apa.csl
```

### Formatting and HTML Tags

- Requirements
  ```sh
  apt install weasyprint
  apt install fonts-noto-cjk
  ```
- Files:
  - Weasyprint configurations (`weasyprint/document.yaml`)
  - Mermaid lua-filter (`mermaid/mermaid-link.lua`)
  - Image Tag lua-filter (`figures/raw-img.lua`)
- Usage
  ```sh
  pandoc <INPUT_MARKDOWN> -o <OUTPUT_FILE> -f markdown \
    -d document.yaml \
    --lua-filter=raw-img.lua \
    --lua-filter=mermaid-link.lua
  ```

### Convert HTML to DOCX via Libreoffice

- Usage
  ```sh
  pandoc <INPUT_MARKDOWN> -o <OUTPUT_HTML> -s
        soffice --headless \
                    --infilter="HTML (StarWriter)" \
                    --convert-to "docx:MS Word 2007 XML" \
                    <OUTPUT_HTML>
  ```
