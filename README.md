Victor
======

Introduction
------------
Victor is a Docker image provides a way to build a static website from 
a [Hugo](https://gohugo.io)-based Git repository. The static website is then served by Nginx. 


Usage
-----

### Environment variables
Pass the following environment variables when instantiating the docker container:

#### SSH_KEY
Base64 encoded SSH private key used to connect to your Git repository.

#### GIT_REPO
The URL of the git repository.

#### GIT_BRANCH
The branch to use (defaults to master if not passed).
