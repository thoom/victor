Victor
======

Introduction
------------
Victor is a Docker image provides a way to build a static website from 
a [Hugo](https://gohugo.io)-based Git repository. The static website is then served by Nginx. 


Usage
-----

### Themes
You can manage themes 2 ways:
1. Copy the theme into the themes folder.
2. Create a git submodule for the theme.

### Environment variables
Pass the following environment variables when instantiating the docker container:

#### SSH_KEY
Base64 encoded SSH private key used to connect to your Git repository.

#### GIT_REPO
The URL of the git repository.

#### GIT_BRANCH
The branch to use (defaults to master if not passed).

#### BASE_URL
If set, hugo will build canonified URLS using the base url. 
Useful if you want the site to build to a different URL than defined in the configuation file.

#### BUILD_ON_START
If set, hugo will be rebuild on container restart.
Useful if you also want to use this image in development.

#### HUGO_ARGS
Add additional hugo arguments on build
