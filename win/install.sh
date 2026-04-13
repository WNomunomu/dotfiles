#!/bin/bash

# dotfiles install script
# このスクリプトは dotfiles ディレクトリから各設定ファイルにシンボリックリンクを作成します

set -e

# 色付きの出力用
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# dotfilesルートディレクトリのパス
DOTFILES_DIR="$(cd "$(dirname "$0")/.." && pwd)"

# ログ関数
log_info() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

log_warn() {
    echo -e "${YELLOW}[WARN]${NC} $1"
}

log_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# バックアップを作成する関数
backup_file() {
    local file="$1"
    local backup_file="${file}.backup.$(date +%Y%m%d_%H%M%S)"

    if [ -e "$file" ] || [ -L "$file" ]; then
        log_warn "Backing up existing file: $file -> $backup_file"
        mv "$file" "$backup_file"
    fi
}

# シンボリックリンクを作成する関数
create_symlink() {
    local source="$1"
    local target="$2"

    # ターゲットディレクトリが存在しない場合は作成
    local target_dir="$(dirname "$target")"
    if [ ! -d "$target_dir" ]; then
        log_info "Creating directory: $target_dir"
        mkdir -p "$target_dir"
    fi

    # 既存のファイル/リンクがある場合はバックアップ
    backup_file "$target"

    # シンボリックリンクを作成
    ln -s "$source" "$target"
    log_info "Created symlink: $target -> $source"
}

# メイン処理
main() {
    log_info "Starting dotfiles installation from: $DOTFILES_DIR"

    # .zshrc
    create_symlink "$DOTFILES_DIR/common/.zshrc" "$HOME/.zshrc"

    # .tmux.conf
    create_symlink "$DOTFILES_DIR/common/.tmux.conf" "$HOME/.tmux.conf"

    # .config/nvim の全体をシンボリックリンク
    create_symlink "$DOTFILES_DIR/common/.config/nvim" "$HOME/.config/nvim"

    # mytheme.zsh-theme
    create_symlink "$DOTFILES_DIR/common/mytheme.zsh-theme" "$HOME/.oh-my-zsh/custom/themes/mytheme.zsh-theme"

    log_info "Dotfiles installation completed!"
    log_info ""
    log_info "Next steps:"
    log_info "  1. Restart your shell or run: source ~/.zshrc"
    log_info "  2. For tmux: reload config with Ctrl+b then r (if configured)"
    log_info "  3. Open nvim to ensure configuration is loaded correctly"
}

# 確認プロンプト
confirm() {
    echo -e "${YELLOW}This will create symlinks for your dotfiles.${NC}"
    echo "Existing files will be backed up with timestamp suffix."
    echo ""
    echo "Files to be linked:"
    echo "  ~/.zshrc"
    echo "  ~/.tmux.conf"
    echo "  ~/.config/nvim/"
    echo "  ~/.oh-my-zsh/custom/themes/mytheme.zsh-theme"
    echo ""
    read -p "Continue? (y/N): " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        echo "Installation cancelled."
        exit 1
    fi
}

# スクリプト実行
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    confirm
    main
fi
