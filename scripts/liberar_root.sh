#!/bin/bash

# Lista dos hosts
HOSTS=("192.168.1.8" "192.168.1.10" "192.168.1.11" "192.168.1.12" "192.168.1.13")

# Caminho da chave pública do usuário carlos
PUBKEY_PATH="/home/carlos/.ssh/id_ed25519.pub"

for HOST in "${HOSTS[@]}"; do
  echo "🔧 Configurando $HOST..."

  ssh carlos@$HOST <<EOF
    sudo mkdir -p /root/.ssh
    cat $PUBKEY_PATH | sudo tee /root/.ssh/authorized_keys > /dev/null
    sudo chown root:root /root/.ssh /root/.ssh/authorized_keys
    sudo chmod 700 /root/.ssh
    sudo chmod 600 /root/.ssh/authorized_keys
    sudo sed -i 's/^#*PermitRootLogin.*/PermitRootLogin yes/' /etc/ssh/sshd_config
    sudo sed -i 's/^#*PasswordAuthentication.*/PasswordAuthentication yes/' /etc/ssh/sshd_config
    sudo systemctl restart ssh
EOF

  echo "✅ Root liberado em $HOST"
done

