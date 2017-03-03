FROM nginx:alpine
MAINTAINER Z. d. Peacock <zdp@thoomtech.com>

ENV HUGO_VERSION=0.19
RUN apk add --no-cache --update \
    wget \
    ca-certificates \
    openssh-client \
    git \
    py-pygments \
    tini \
    && cd /tmp/ \
    && wget https://github.com/spf13/hugo/releases/download/v${HUGO_VERSION}/hugo_${HUGO_VERSION}_Linux-64bit.tar.gz \
    && tar xzf hugo_${HUGO_VERSION}_Linux-64bit.tar.gz \
    && rm -r hugo_${HUGO_VERSION}_Linux-64bit.tar.gz \
    && mv hugo*/hugo* /usr/bin/hugo

ADD conf/nginx-site.conf /etc/nginx/conf.d/default.conf

# Add Scripts
ADD scripts/start.sh /start.sh

# copy in code
ADD src/ /var/www/

EXPOSE 80
ENTRYPOINT ["/sbin/tini", "-g", "--"]
CMD ["sh", "/start.sh"]
