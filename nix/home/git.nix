{ ... }:
{
  programs.git = {
    enable = true;
    userName = "WNomunomu";
    userEmail = "kohsei.nmr@gmail.com";
    delta.enable = true;
    extraConfig = {
      init.defaultBranch = "main";
      pull.rebase = true;
      push.autoSetupRemote = true;
    };
    ignores = [
      ".DS_Store"
      "*.swp"
      ".direnv/"
    ];
  };
}
