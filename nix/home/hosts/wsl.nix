{ ... }:
{
  home.homeDirectory = "/home/kohsei";

  home.sessionVariables = {
    EDITOR = "nvim";
    # WSL用にブラウザ起動を委譲したい場合
    # BROWSER = "wslview";
  };
}
