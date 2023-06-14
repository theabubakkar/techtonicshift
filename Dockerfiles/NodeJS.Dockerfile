FROM node:latest

# Install curl
RUN apt-get update && \
    apt-get install -y curl

# Install jq
RUN apt-get update && \
    apt-get install -y jq

# Install xmlstarlet
RUN apt-get update && \
    apt-get install -y xmlstarlet