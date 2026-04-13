export ZSH="$HOME/.oh-my-zsh"

# ZSH_THEME="geoffgarside"
ZSH_THEME="mytheme"

ZSH_DISABLE_COMPFIX=true

# Speed: intercept oh-my-zsh's compinit to use -C (skip compaudit, ~270ms faster)
# oh-my-zsh already validates/invalidates the dump before calling compinit,
# so -C is safe here. On first run or when plugins change, dump is rebuilt once.
autoload -Uz compinit
function compinit() {
  unfunction compinit
  autoload -Uz compinit
  local dump="${ZSH_COMPDUMP:-${ZDOTDIR:-$HOME}/.zcompdump}"
  if [[ -f "$dump" ]]; then
    compinit -C -d "$dump"
  else
    compinit -d "$dump"
  fi
}

plugins=(git kube-ps1)

PROMPT='$(kube_ps1)'$PROMPT
source $ZSH/oh-my-zsh.sh

# eval $(dircolors -b ~/.dircolors)

alias -s {gif,jpg,jpeg,png,bmp}='display'
alias -s {html,pdf,ppt,pptx,xls,xlsx,doc,docx}=open

alias k="kubectl"
alias cal="ncal -C"
alias yolo="claude --dangerously-skip-permissions"
alias vim="nvim"
alias g++='g++ -std=c++20'

if [[ "$(uname -s)" == "Linux" ]]; then
  # WSL / win
  alias open="cmd.exe /C start"
  alias win="/mnt/c/Users/kohse"
  alias waseda="/mnt/c/Users/kohse/Documents/waseda"
  alias brave="/mnt/c/Program\ Files/BraveSoftware/Brave-Browser/Application/brave.exe"
  alias braves="brave -incognito"
  alias slack="/mnt/c/Users/kohse/AppData/Local/slack/*/slack.exe"
  alias line="/mnt/c/Users/kohse/AppData/Local/LINE/bin/*/LINE.exe"
  alias tanuki='brave web.whatsapp.com'
  alias clip="clip.exe"
  alias powerconfig="powercfg.exe"
  # alias high="powerconfig -duplicatescheme e9a42b02-d5df-448d-aa00-03f14749eb61 && powercfg -setactive 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c"
  alias high="powerconfig -setactive 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c && powerconfig -list"
  alias balance="powerconfig -setactive SCHEME_BALANCED && powerconfig -list"
  alias win32yank="win32yank.exe"

  export PYENV_ROOT="$HOME/.pyenv"
  # Static PATH (replaces `eval "$(pyenv init --path)"` to avoid 90ms subprocess)
  export PATH="$PYENV_ROOT/shims:$PYENV_ROOT/bin:$PATH"

  # Static brew env (replaces `eval "$(brew shellenv)"` to avoid 20ms subprocess)
  export HOMEBREW_PREFIX="$HOME/homebrew"
  export HOMEBREW_CELLAR="$HOME/homebrew/Cellar"
  export HOMEBREW_REPOSITORY="$HOME/homebrew"
  fpath[1,0]="$HOME/homebrew/share/zsh/site-functions"
  export PATH="$HOME/homebrew/bin:$HOME/homebrew/sbin${PATH+:$PATH}"
  [ -z "${MANPATH-}" ] || export MANPATH=":${MANPATH#:}"
  export INFOPATH="$HOME/homebrew/share/info:${INFOPATH:-}"

  . "/home/kohsei/.deno/env"
  export PATH=$PATH:/usr/local/go/bin
  export PATH="$HOME/.local/bin:$PATH"

  dc-down() {
    devcontainer down --workspace-folder . 2>/dev/null || \
      docker ps --filter "label=devcontainer.local_folder=$(pwd)" --format '{{.ID}}' | xargs -r docker stop
  }

  dc() {
    case "$1" in
      up)
        shift
        devcontainer up --workspace-folder . "$@"
        ;;
      exec)
        shift
        devcontainer exec --workspace-folder . "$@"
        ;;
      down)
        dc-down
        ;;
      rebuild)
        shift
        devcontainer up --workspace-folder . --remove-existing-container "$@"
        ;;
      shell)
        devcontainer exec --workspace-folder . /bin/bash 2>/dev/null || \
        devcontainer exec --workspace-folder . /bin/sh
        ;;
      *)
        echo "Usage: dc {up|exec|down|rebuild|shell}"
        echo ""
        echo "Commands:"
        echo "  up      - Build and start the devcontainer"
        echo "  exec    - Execute a command in the devcontainer"
        echo "  down    - Stop the devcontainer"
        echo "  rebuild - Rebuild the devcontainer from scratch"
        echo "  shell   - Open a shell in the devcontainer"
        ;;
    esac
  }
else
  # mac
  alias clip="pbcopy"
fi

export NVM_DIR="$HOME/.nvm"
# Lazy load nvm: only initialize when nvm/node/npm/npx is first used
_nvm_load() {
  unset -f nvm node npm npx yarn pnpm
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
  [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
}
nvm()  { _nvm_load; nvm  "$@"; }
node() { _nvm_load; node "$@"; }
npm()  { _nvm_load; npm  "$@"; }
npx()  { _nvm_load; npx  "$@"; }
yarn() { _nvm_load; yarn "$@"; }
pnpm() { _nvm_load; pnpm "$@"; }

export PATH="$PATH:/opt/nvim-linux-x86_64/bin"

# プロンプト描画前に毎回カーソルを細いバー（steady bar）に戻す。
# nvim や tmux のコピーモードなどから戻った際にカーソルが太いまま残るのを防ぐ。
_reset_cursor_beam() { print -n '\e[6 q' }
precmd_functions+=(_reset_cursor_beam)

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
  files=$(git status --porcelain | sed 's/^...//' | fzf -m --prompt="Add files > ")
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
fless() {
  local file
  file=$(find ${1:-.} -type f 2>/dev/null | fzf --prompt="View file > " --preview="head -100 {}")
  [ -n "$file" ] && less "$file"
}

# 隠しファイルも含めてファイル検索
ffind() {
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
