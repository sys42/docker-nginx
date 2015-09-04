FROM sys42/docker-base:1.1.0
MAINTAINER Tom Nussbaumer <thomas.nussbaumer@gmx.net>

ADD . /_tmp

RUN set -e                                                  && \
    export LC_ALL=C                                         && \
    export DEBIAN_FRONTEND=noninteractive                   && \
    set -x                                                  && \
    . /etc/environment                                      && \
    [ ! -e /var/lib/apt/lists/lock ] && apt-get update      && \
    apt-get install -y --no-install-recommends nginx-extras && \
    apt-get clean                                           && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*           && \
    cp /_tmp/cfg/nginx.conf /etc/nginx/nginx.conf           && \
    mkdir -p /etc/nginx/main.d                              && \
    cp /_tmp/cfg/nginx_main_d_default.conf                     \
       /etc/nginx/main.d/default.conf &&                       \
    mkdir /etc/service/nginx                                && \
    cp /_tmp/runit/nginx /etc/service/nginx/run             && \
    mkdir /etc/service/nginx-log-forwarder                  && \
    cp /_tmp/runit/nginx-log-forwarder                         \
       /etc/service/nginx-log-forwarder/run                 && \
    rm -rf /_tmp

EXPOSE 443
EXPOSE 80

ENTRYPOINT ["/sbin/my_init", "--"]
