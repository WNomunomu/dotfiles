{ ... }:
{
  imports = [
    ./packages.nix
    ./shell.nix
    ./git.nix
    ./neovim.nix
  ];

  home.username = "kohsei";
  home.stateVersion = "24.11";

  programs.home-manager.enable = true;

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };
}
