# Blake's ZSH Config

## Instructions:
- Clone repo into `$HOME`
  - `git clone https://github.com/blake-riley/zsh-config ~/.zsh`
- Copy `.zshrc` into your `$HOME`
- Copy `.zprofile` into your `$HOME`
- Change shell (permanently) with `sudo chsh -s /usr/local/bin/zsh`
- Compile .zsh scripts with `zsh-recompile`

_NB: I have hidden servers.zsh, as it can contain sensitive information._  
_You may need to `touch servers.zsh`._

_NB: If you get errors about insecure files, investigate compaudit._
_If you are powerless to secure these files, then add '-u' to compinit calls in .zprofile and completions.zsh._

## Dependencies:
- Homebrew
- zsh (`brew install zsh`)
- powerline-status (`pip3 install --user powerline-status`)
- virtualenv (`pip3 install --user virtualenv virtualenvwrapper`)

## TODO:
- Fix Ctrl+C error
- Add errorcodes to RPROMPT
