
sudo apt update && sudo apt upgrade -y
sudo apt install certbot openssl bind9-dnsutils -y

# Create windows directory for certbot to use
sudo mkdir -p /mnt/c/letsencrypt
sudo chown $USER:$USER /mnt/c/letsencrypt
sudo chmod 700 /mnt/c/letsencrypt
