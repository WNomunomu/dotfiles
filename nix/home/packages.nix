{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # 検索・閲覧
    ripgrep
    fd
    bat
    jq
    yq-go
    fzf
    eza
    tree

    # Git/GitHub
    gh
    git-lfs
    lazygit
    delta

    # Kubernetes/インフラ
    kubectl
    kubectx
    k9s
    helm
    helmfile
    kustomize
    istioctl
    google-cloud-sdk

    # IaC
    terraform

    # ネットワーク・転送
    ngrok
    lftp
    whois

    # 一般ツール
    pandoc
    rename
    detox
    fastfetch
    convmv
    ansible
    lazydocker
    imagemagick

    # Anthropic
    claude-code
  ];
}
