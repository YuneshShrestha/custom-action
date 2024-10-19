# Use a base image that has bash installed
FROM ubuntu:latest

# Install dependencies, including Git
RUN apt-get update && apt-get install -y \
  git \
  bash

# Set the entrypoint to your script
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
