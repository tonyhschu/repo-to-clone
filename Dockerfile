# Dockerfile
# using debian:jessie for it's smaller size over ubuntu
FROM debian:jessie

# Replace shell with bash so we can source files
RUN rm /bin/sh && ln -s /bin/bash /bin/sh

# Set environment variables
ENV appDir /var/www/repo/

# Run updates and install deps
RUN apt-get update

RUN apt-get install -y -q --no-install-recommends \
    apt-transport-https \
    build-essential \
    ca-certificates \
    curl \
    g++ \
    gcc \
    git \
    make \
    nginx \
    sudo \
    wget \
    && rm -rf /var/lib/apt/lists/* \
    && apt-get -y autoclean

# Set the work directory
RUN mkdir -p /var/www/repo
WORKDIR ${appDir}

COPY . ./

RUN make

EXPOSE 80

CMD ["python", "-m", "SimpleHTTPServer", "80"]
