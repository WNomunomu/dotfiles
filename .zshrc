export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="geoffgarside"

plugins=(git kube-ps1)

PROMPT='$(kube_ps1)'$PROMPT
source $ZSH/oh-my-zsh.sh

eval $(dircolors -b ~/.dircolors)

alias -s {gif,jpg,jpeg,png,bmp}='display'
alias -s {html,pdf,ppt,pptx,xls,xlsx,doc,docx}=open

alias open="cmd.exe /C start"
alias win="/mnt/c/Users/kohse"
alias waseda="/mnt/c/Users/kohse/Documents/waseda"
alias brave="/mnt/c/Program\ Files/BraveSoftware/Brave-Browser/Application/brave.exe"
alias braves="brave -incognito"
alias slack="/mnt/c/Users/kohse/AppData/Local/slack/*/slack.exe"
alias line="/mnt/c/Users/kohse/AppData/Local/LINE/bin/*/LINE.exe"
alias k="kubectl"
alias cal="ncal -C"
alias yolo="claude --dangerously-skip-permissions"
alias clip="clip.exe"

export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

eval "$(~/homebrew/bin/brew shellenv)"

alias powerconfig="powercfg.exe"
# alias high="powerconfig -duplicatescheme e9a42b02-d5df-448d-aa00-03f14749eb61 && powercfg -setactive 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c"
alias high="powerconfig -setactive 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c && powerconfig -list"
alias balance="powerconfig -setactive SCHEME_BALANCED && powerconfig -list"

export PATH="$PATH:/opt/nvim-linux-x86_64/bin"

alias win32yank="win32yank.exe"

gs() {
  local hash=$(git log --oneline | fzf | awk '{print $1}')
  [ -n "$hash" ] && git show "$hash"
}

# echo -ne '\e[6 q'

