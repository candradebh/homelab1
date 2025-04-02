{
  description = "Homelab";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
  };

  outputs = { self, nixpkgs }: {
    devShells.x86_64-linux.default = let
      pkgs = import nixpkgs { system = "x86_64-linux"; };
    in pkgs.mkShell {
      packages = with pkgs; [
        ansible
        ansible-lint
        bmake
        diffutils
        docker
        docker-compose
        dyff
        git
        go
        gotestsum
        iproute2
        jq
        k9s
        kanidm
        kube3d
        kubectl
        kubernetes-helm
        kustomize
        libisoburn
        neovim
        openssh
        opentofu
        p7zip
        pre-commit
        qrencode
        shellcheck
        wireguard-tools
        yamllint
        (python3.withPackages (ps: with ps; [
          jinja2
          kubernetes
          mkdocs-material
          netaddr
          pexpect
          rich
        ]))
      ];
    };
  };
}
