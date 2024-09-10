FROM ubuntu:latest

# Install necessary tools
RUN apt-get update && \
    apt-get install -y curl jq 

# Copy entrypoint script
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]