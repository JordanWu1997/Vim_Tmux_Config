# Convert Chinese Markdown to PDF file

- References
  - https://chatgpt.com

## Preparation

### Install LaTex Suite on Linux

- On Fedora: https://docs.fedoraproject.org/en-US/neurofedora/latex/
  ```sh
  sudo dnf install texlive-scheme-full
  ```
- On Ubuntu: https://www.liuxiao.org/2019/11/texlive-texstudio-%E9%85%8D%E7%BD%AE%E4%B8%8E%E4%BD%BF%E7%94%A8/
  ```sh
  sudo apt install texlive-full
  ```

### Install Latest LaTex Suite

- References
  - https://www.arong-xu.com/posts/texlive-2025-minimal-install-with-cmd-on-ubuntu/
- Install texlive
  ```sh
  # Install texlive scheme-full mannually
  mkdir -p $HOME/Desktop/texlive/2025
  cd $HOME/Desktop/texlive
  wget https://mirrors.aliyun.com/CTAN/systems/texlive/tlnet/install-tl-unx.tar.gz
  tar xzvf install-tl-unx.tar.gz
  cd install-tl-unix
  ./install-tl \
      --scheme=scheme-full \
      --repository="https://mirrors.tuna.tsinghua.edu.cn/CTAN/systems/texlive/tlnet/" \
      --texdir=$HOME/Desktop/texlive/2025 \
      --portable \
      --no-gui \
      --no-doc-install \
      --no-src-install \
      --no-interaction
  ```
- Copy installed fonts to system and update font cache
  ```sh
  # Copy font to system dir and update font cache
  sudo cp $HOME/Desktop/texlive/2025/texmf-var/fonts/conf/texlive-fontconfig.conf \
      /etc/fonts/conf.d/09-texlive.conf
  sudo fc-cache -fsv
  ```
- Add texlive binary directory to $PATH
  ```sh
  echo 'export PATH="$HOME/Desktop/texlive/2025/bin/x86_64-linux:$PATH"' >> $HOME/.profile
  ```
- Check installed texlive
  ```sh
  # Check installed texlive version
  tlmgr --version
  ```

### Install Static Fonts for Traditional Chinese (TC)

1. Download `Noto Sans TC` font from [Google Official Repo](https://fonts.google.com/selection)
2. Unzip and move all `*.ttf` files to `$HOME/.local/share/fonts`
3. Run `fc-cache -f -v` to update fonts
4. Check if fonts are installed by running the following command
   ```sh
   # This shows all available TC fonts
   fc-list :lang=zh | grep -i "source han\|noto\|uming\|ukai" | cut -d: -f2 | sort -u
   ```

## Example

- Run (make sure that you use static fonts that support TC)
  ```sh
  pandoc example.md -o output.pdf --pdf-engine=xelatex -V mainfont="Noto Sans TC"
  ```
  - If you encounter problem using `xelatex`, switch to `lualatex` may help
