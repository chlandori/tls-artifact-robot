# Use a lightweight base image
FROM debian:bullseye-slim

# Install certbot and dependencies
RUN apt-get update && \
    apt-get install -y certbot && \
    rm -rf /var/lib/apt/lists/*

# Create a working directory
WORKDIR /etc/letsencrypt

# Default command (we’ll override with docker run)
CMD ["certbot", "--help"]

