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
