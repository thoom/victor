#!/bin/sh

cd /var/www

# Dont pull code down if the .git folder exists
if [ ! -d ".git" ]; then
  # Disable Strict Host checking for non interactive git clones
  mkdir -p -m 0700 /root/.ssh
  echo -e "Host *\n\tStrictHostKeyChecking no\n" >> /root/.ssh/config

  # Use the ssh key if passed
  if [ ! -z "$SSH_KEY" ]; then
    echo $SSH_KEY > /root/.ssh/id_rsa.base64
    base64 -d /root/.ssh/id_rsa.base64 > /root/.ssh/id_rsa
    chmod 600 /root/.ssh/id_rsa
  fi

  # Pull down code from git
  if [ ! -z "$GIT_REPO" ]; then
    
    # Remove any data in the directory
    rm -Rf /var/www/*
    
    if [ ! -z "$GIT_BRANCH" ]; then
      git clone --recursive -b $GIT_BRANCH $GIT_REPO /var/www
    else
      git clone --recursive $GIT_REPO /var/www
    fi

    BUILD=true
  fi
fi

if [ ! -z "$BUILD_ON_START" ]; then
  BUILD=true
fi

if [ ! -z "$BUILD" ]; then
  rm -Rf /var/www/public

  HUGO_ARGS=$CLI_ARGS
  if [ ! -z "$BASE_URL" ]; then
     HUGO_ARGS="$HUGO_ARGS --baseURL $BASE_URL --canonifyURLs"
  fi

  hugo $HUGO_ARGS
fi

# Always chown webroot for better mounting
#chown -Rf nginx.nginx /var/www/public

# Start nginx
nginx -g "daemon off;"
