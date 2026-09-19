# README

## Usage

- By default, all HTML image tags are ignored by `pandoc`
  ```sh
  # Baseline conversions (Examples B and D images will be missing from PDF/DOCX)
  pandoc example.md -s -o out/test-baseline.html
  pandoc example.md -s -o out/test-baseline.pdf
  pandoc example.md -s -o out/test-baseline.docx
  ```
- Lua-filter to save all HTML image tags
  ```sh
  # With the filter (all four examples survive)
  pandoc example.md -s --lua-filter=raw-img.lua -o out/test-filtered.pdf
  pandoc example.md -s --lua-filter=raw-img.lua -o out/test-filtered.docx
  ```
