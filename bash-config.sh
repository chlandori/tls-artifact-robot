
sudo apt update && sudo apt upgrade -y
sudo apt install docker.io openssl bind9-dnsutils -y

# Create windows directory for certbot to use
sudo mkdir -p /mnt/c/letsencrypt
sudo chown $USER:$USER /mnt/c/letsencrypt

# Build the Docker image for certbot
docker build -t tls-artifact-robot .
