# Convert Chinese Markdown to PDF file

- References
  - https://chatgpt.com

## Preparation

### Install LaTex Suite on Linux

- On Fedora: https://docs.fedoraproject.org/en-US/neurofedora/latex/
  ```sh
  sudo dnf install texlive-scheme-full
  ```

### Install Static Fonts for Traditional Chinese (TC)

1. Download `Noto Sans TC` font from [Google Official Repo](https://fonts.google.com/selection)
2. Unzip and move all `*.ttf` files to `$HOME/.local/share/fonts`
3. Run `fc-cache -f -v` to update fonts
4. Check if fonts are installed by running the following command
   ```sh
   #_This shows all available TC fonts
   fc-list :lang=zh | grep -i "source han\|noto\|uming\|ukai" | cut -d: -f2 | sort -u
   ```

## Example

- Run
  ```sh
  pandoc example.md -o output.pdf --pdf-engine=xelatex -V mainfont="Noto Sans TC"
  ```
  - If you encounter problem using `xelatex`, switch to `lualatex` may help
