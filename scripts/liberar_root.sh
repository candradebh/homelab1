#!/bin/bash

# Lista dos hosts
HOSTS=("192.168.1.8" "192.168.1.10" "192.168.1.11" "192.168.1.12")

# Caminho da chave pública do usuário carlos
PUBKEY_PATH="/home/carlos/.ssh/id_ed25519.pub"

# reseta se vc trocar o so da vm e pegar mesmo ip.
# for host in "${HOSTS[@]}"; do ssh-keygen -R "$host"; done

read -s -p "Digite a senha do usuário carlos: " SENHA
echo

for HOST in "${HOSTS[@]}"; do
  echo "🔧 Configurando $HOST..."

  ssh carlos@$HOST "echo \"$SENHA\" | sudo -S mkdir -p /root/.ssh && \
                    echo \"$SENHA\" | sudo -S cp ~/.ssh/authorized_keys /root/.ssh/authorized_keys && \
                    echo \"$SENHA\" | sudo -S chown root:root /root/.ssh /root/.ssh/authorized_keys && \
                    echo \"$SENHA\" | sudo -S chmod 700 /root/.ssh && \
                    echo \"$SENHA\" | sudo -S chmod 600 /root/.ssh/authorized_keys && \
                    echo \"$SENHA\" | sudo -S sed -i 's/^#*PermitRootLogin.*/PermitRootLogin yes/' /etc/ssh/sshd_config && \
                    echo \"$SENHA\" | sudo -S sed -i 's/^#*PasswordAuthentication.*/PasswordAuthentication yes/' /etc/ssh/sshd_config && \
                    echo \"$SENHA\" | sudo -S systemctl restart ssh"
done
