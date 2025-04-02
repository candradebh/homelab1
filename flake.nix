{
  description = "Homelab";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
      in
      {
        devShells.${system}.default = pkgs.mkShell {
          packages = [
            pkgs.ansible
            pkgs.ansible-lint
            pkgs.bmake
            pkgs.diffutils
            pkgs.docker
            pkgs.docker-compose
            pkgs.dyff
            pkgs.git
            pkgs.go
            pkgs.gotestsum
            pkgs.iproute2
            pkgs.jq
            pkgs.k9s
            pkgs.kanidm
            pkgs.kube3d
            pkgs.kubectl
            pkgs.kubernetes-helm
            pkgs.kustomize
            pkgs.libisoburn
            pkgs.neovim
            pkgs.openssh
            pkgs.opentofu
            pkgs.p7zip
            pkgs.pre-commit
            pkgs.qrencode
            pkgs.shellcheck
            pkgs.wireguard-tools
            pkgs.yamllint

            (pkgs.python3.withPackages (p: with p; [
              jinja2
              kubernetes
              mkdocs-material
              netaddr
              pexpect
              rich
            ]))
          ];
        };
      }
    );
}
