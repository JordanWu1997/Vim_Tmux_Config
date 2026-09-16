# README

## Installation

```sh
apt install Weasyprint
```

## Usage

```sh
pandoc -f markdown -d document.yaml -o <OUTPUT_PDF> <INPUT_MARKDOWN>
```

### Example

```sh
pandoc -f markdown -d document.yaml -o example.pdf example.md
```
