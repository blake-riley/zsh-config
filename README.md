# Blake's ZSH Config

## Instructions:

- Clone repo into `$HOME` & update subrepos
  - `git clone https://github.com/blake-riley/zsh-config ~/.zsh`
  - `cd ~/.zsh && git submodule init && git submodule update`
- Link `.zshrc` into your `$HOME`, with `ln -s ~/.zsh/.zshrc ~/.zshrc`
- Change shell (permanently), with `sudo chsh -s /usr/local/bin/zsh`
- Install NerdFonts for terminal (`brew tap homebrew/cask-fonts; brew cask install font-hack-nerd-font`), and configure your Terminal emulator to use these fonts

_NB: I have hidden servers.zsh, as it can contain sensitive information._  
_You may need to `touch servers.zsh`._

_NB: If you get errors about insecure files, investigate compaudit._
_If you are powerless to secure these files (usually to 755), then add '-u' to compinit calls in .zshrc and completions.zsh._

## Dependencies:

- Homebrew
- zsh (`brew install zsh`)
- A nice terminal emulator

## TODO:

- Fix <Tab> autocomplete eating lines above
