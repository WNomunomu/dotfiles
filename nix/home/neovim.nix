{ pkgs, config, ... }:
{
  home.packages = with pkgs; [
    neovim

    # lazy.nvim経由のプラグインがビルドに使う標準ツール
    gcc
    gnumake
    unzip
    tree-sitter

    # 各種LSP/Formatter(必要なものだけ残す)
    lua-language-server
    nil                # Nix LSP
    nixfmt-rfc-style   # Nix formatter
    typescript-language-server
    pyright
    gopls
    rust-analyzer
    stylua
    prettierd
  ];

  # common/.config/nvim をそのまま ~/.config/nvim にリンク
  xdg.configFile."nvim".source =
    config.lib.file.mkOutOfStoreSymlink
      "${config.home.homeDirectory}/dotfiles/common/.config/nvim";
}
