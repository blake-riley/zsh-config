# Blake's ZSH Config

## Instructions:

- Clone repo into `$HOME` & update subrepos
  - `git clone https://github.com/blake-riley/zsh-config ~/.zsh`
  - `cd ~/.zsh && git submodule init && git submodule update`
- Link `.zshrc` into your `$HOME`, with `ln -s ~/.zsh/.zshrc ~/.zshrc`
- Link `.zshenv` into your `$HOME`, with `ln -s ~/.zsh/.zshenv ~/.zshenv`
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


# Secret Management

## Additional dependencies

- jq (`brew install jq`) json parser
- ejson (`brew install shopify/shopify/ejson`) json encrypter for secrets

## Adding secrets to .secrets.ejson

- 1. Make sure you have the secret in ${EJSON_KEYDIR}
- 2. `add_secret ${ZSH_SECRETS_FILE} <VARNAME> <SECRET>`
- 3. `ejson encrypt ${ZSH_SECRETS_FILE}`
- 4. Add, commit & push the changes to ZSH_SECRETS_FILE to the repo.


# TODO:

- Fix <Tab> autocomplete eating lines above
