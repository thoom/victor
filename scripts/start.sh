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
    
    # Remove the test file
    rm -Rf /var/www/*
    
    if [ ! -z "$GIT_BRANCH" ]; then
      git clone --recursive -b $GIT_BRANCH $GIT_REPO /var/www
    else
      git clone --recursive $GIT_REPO /var/www
    fi

    if [ ! -z "$BASE_URL" ]; then
      hugo --baseURL $BASE_URL --canonifyURLs
    else
      hugo
    fi
  fi

  # Always chown webroot for better mounting
  chown -Rf nginx.nginx /var/www
fi

# Start nginx
nginx -g "daemon off;"