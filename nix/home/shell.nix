{ pkgs, config, ... }:
{
  home.packages = with pkgs; [
    zsh
    tmux
  ];

  # 既存の .zshrc を dotfiles repo から直リンク
  home.file.".zshrc".source =
    config.lib.file.mkOutOfStoreSymlink
      "${config.home.homeDirectory}/dotfiles/common/.zshrc";

  # zshテーマも一緒に
  home.file.".oh-my-zsh/custom/themes/mytheme.zsh-theme".source =
    config.lib.file.mkOutOfStoreSymlink
      "${config.home.homeDirectory}/dotfiles/common/mytheme.zsh-theme";

  # tmux.conf
  home.file.".tmux.conf".source =
    config.lib.file.mkOutOfStoreSymlink
      "${config.home.homeDirectory}/dotfiles/common/.tmux.conf";
}
