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

# git log から選択して show
gshow() {
  local hash=$(git log --oneline | fzf | awk '{print $1}')
  [ -n "$hash" ] && git show "$hash"
}

# git branch を選択して checkout
gcheckout() {
  local branch
  branch=$(git branch -a | grep -v HEAD | sed 's/remotes\/origin\///' | sort | uniq | fzf --prompt="Branch > ")
  [ -n "$branch" ] && git checkout "${branch#* }"
}

# git branch を選択して merge
gmerge() {
  local branch
  branch=$(git branch | grep -v "^\*" | fzf --prompt="Merge branch > ")
  [ -n "$branch" ] && git merge "${branch#* }"
}


# git branchを選択してdelete
gbranchdelete() {
  local branch
  branch=$(git branch | grep -v "^\*" | fzf --prompt="Delete branch > ")
  [ -n "$branch" ] && git branch -d "${branch#* }"
}

# git stashを選択してapply/pop
gapply() {
  local stash
  stash=$(git stash list | fzf --prompt="Stash > ")
  [ -n "$stash" ] && git stash apply "${stash%:*}"
}

# git diffを選択したファイルで表示
gdiff() {
  local file
  file=$(git status --porcelain | awk '{print $2}' | fzf --prompt="Diff file > ")
  [ -n "$file" ] && git diff "$file"
}

# git addを選択したファイルで実行
gadd() {
  local files
  files=$(git status --porcelain | awk '{print $2}' | fzf -m --prompt="Add files > ")
  [ -n "$files" ] && echo "$files" | xargs git add
}

# remoteブランチも含めてcheckout
gcheckoutremote() {
  local branch
  branch=$(git branch -a --format="%(refname:short)" | grep -v HEAD | fzf --prompt="Checkout > ")
  [ -n "$branch" ] && {
    if [[ "$branch" == origin/* ]]; then
      git checkout -b "${branch#origin/}" "$branch"
    else
      git checkout "$branch"
    fi
  }
}

# ===================
# ファイル・ディレクトリ操作
# ===================

# 高度なcd（最近訪問したディレクトリも含む）
fcd() {
  local dir
  dir=$(find ${1:-.} -type d 2>/dev/null | fzf --prompt="Directory > ") && cd "$dir"
}

# 最近使ったディレクトリからcd (dirsコマンド使用)
cdd() {
  local dir
  dir=$(dirs -v | fzf --prompt="Recent dirs > " | awk '{print $2}') && cd "$dir"
}

# ファイルを選択してvim/nvimで開く
fvim() {
  local file
  file=$(find ${1:-.} -type f 2>/dev/null | fzf --prompt="Edit file > " --preview="head -100 {}")
  [ -n "$file" ] && ${EDITOR:-vim} "$file"
}

# ファイルを選択してcatで表示
fcat() {
  local file
  file=$(find ${1:-.} -type f 2>/dev/null | fzf --prompt="Cat file > " --preview="head -100 {}")
  [ -n "$file" ] && cat "$file"
}

# ファイルを選択してless/moreで表示
fl() {
  local file
  file=$(find ${1:-.} -type f 2>/dev/null | fzf --prompt="View file > " --preview="head -100 {}")
  [ -n "$file" ] && less "$file"
}

# 隠しファイルも含めてファイル検索
fa() {
  local file
  file=$(find ${1:-.} -name ".*" -o -type f 2>/dev/null | fzf --prompt="All files > " --preview="head -100 {}")
  [ -n "$file" ] && echo "$file"
}

# コマンド履歴を選択して実行
fhistory() {
  local cmd
  cmd=$(history | fzf --tac --prompt="History > " | sed 's/^ *[0-9]* *//')
  [ -n "$cmd" ] && {
    echo "$cmd"
    eval "$cmd"
  }
}

dexec() {
  local container
  container=$(docker ps --format "table {{.Names}}\t{{.Image}}\t{{.Status}}" | tail -n +2 | fzf --prompt="Docker exec > " | awk '{print $1}')
  [ -n "$container" ] && docker exec -it "$container" ${1:-bash}
}

# Dockerコンテナを選択してstop
dstop() {
  local containers
  containers=$(docker ps --format "table {{.Names}}\t{{.Image}}\t{{.Status}}" | tail -n +2 | fzf -m --prompt="Stop containers > " | awk '{print $1}')
  [ -n "$containers" ] && echo "$containers" | xargs docker stop
}

drun() {
  local image
  image=$(docker images --format "table {{.Repository}}\t{{.Tag}}\t{{.ID}}" | tail -n +2 | fzf --prompt="Run image > " | awk '{print $1":"$2}')
  [ -n "$image" ] && docker run -it "$image" ${1:-bash}
}

