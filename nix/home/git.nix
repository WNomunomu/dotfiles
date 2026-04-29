{ ... }:
{
  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "WNomunomu";
        email = "kohsei.nmr@gmail.com";
      };
      init.defaultBranch = "main";
      pull.rebase = true;
      push.autoSetupRemote = true;
    };
    signing.format = "openpgp";
    ignores = [
      ".DS_Store"
      "*.swp"
      ".direnv/"
    ];
  };

  programs.delta = {
    enable = true;
    enableGitIntegration = true;
  };
}
