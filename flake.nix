{
  description = "Homelab Development Environment";

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
        devShells.default = pkgs.mkShell {
          # Lista de pacotes necessários para o ambiente de desenvolvimento
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

          # Comandos executados ao entrar no ambiente de desenvolvimento
          shellHook = ''
            echo "Bem-vindo ao ambiente de desenvolvimento do Homelab!"
            # Adicione aqui quaisquer comandos adicionais que deseja executar ao iniciar o shell
          '';
        };
      }
    );
}
