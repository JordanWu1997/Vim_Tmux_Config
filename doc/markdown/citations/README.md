# Citation in Markdown

- References
  - https://github.com/citation-style-language/styles
  - https://www.youtube.com/watch?v=hpAJMSS8pvs&list=PLXt-tu7G1H3tLeZgbbUmYjE0_kvbjA4YU&index=1
  - https://github.com/shd101wyy/markdown-preview-enhanced/blob/master/docs/pandoc-bibliographies-and-citations.md

## Citation Files

- Citation Style Configuration
  ```
  --csl=<CSL_FILE>
  ```
- Biography
  ```
  --biography=<BIO_FILE>
  ```
- Enable Citation in Pandoc
  - Before pandoc 2.11
    - Requirement: additional filter `citeproc`
      - Installation:
        ```sh
        sudo apt install pandoc-citeproc
        ```
    - Usage
      ```
      --filter pandoc-citeproc
      ```
  - After pandoc 2.11
    ```
    --citeproc
    ```

## Example

- For pandoc 2.9
  ```sh
  pandoc --filter pandoc-citeproc document.md -o document.pdf --csl apa.csl
  ```
