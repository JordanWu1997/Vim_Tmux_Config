# Mermaid Chart/Diagram in Markdown



## Usage: Export Mermaid Chart/Diagram as PDF

```sh
pandoc -f markdown -L mermaid-link.lua -o <OUTPUT_PDF> <INPUT_MARKDOWN>
```

### Example

```sh
pandoc -f markdown -L mermaid-link.lua -o example.pdf example.md
```

## Usage: Export Mermaid Chart/Diagram as HTM

```sh
pandoc -f markdown -L mermaid-link.lua -o <OUTPUT_HTML> <INPUT_MARKDOWN>
```

### Example

```sh
pandoc -f markdown -L mermaid-link.lua -o example.html example.md
```
