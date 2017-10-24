FROM debian:jessie
LABEL maintainer "Cheewai Lai <clai@csir.co.za>"

ARG GOSU_VERSION=1.10
ARG GOSU_DOWNLOAD_URL="https://github.com/tianon/gosu/releases/download/${GOSU_VERSION}/gosu-amd64"
ARG DEBIAN_FRONTEND=noninteractive
ARG DOCKERIZE_VERSION=v0.5.0

RUN \
  echo "deb http://httpredir.debian.org/debian jessie main" >/etc/apt/sources.list \
  && echo "deb http://httpredir.debian.org/debian jessie-updates main" >>/etc/apt/sources.list \
  && echo "deb http://security.debian.org/ jessie/updates main" >>/etc/apt/sources.list  \
  && apt-get update \
  && apt-get -y --force-yes --no-install-recommends --fix-missing install python-pip python-psycopg2  python-yaml libgeos-c1 libxml2-dev build-essential gcc python-dev libblas-dev liblapack-dev libatlas-base-dev gfortran \
  && apt-get -y install python-numpy python-scipy python-matplotlib ipython ipython-notebook python-pandas python-sympy python-nose curl \
  && apt-get update \
  && apt-get -y dist-upgrade \
  && curl -o /tmp/gosu -kfsSL "$GOSU_DOWNLOAD_URL" \
  && mv /tmp/gosu /usr/bin/gosu \
  && chmod +x /usr/bin/gosu \
  && curl -fsSL https://github.com/jwilder/dockerize/releases/download/$DOCKERIZE_VERSION/dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz | tar xfz - -C /usr/bin \
  && pip install --upgrade pip \
  && ldconfig \
  && pip install simplekml flask reverse_geocoder python-dateutil uwsgi \
  && pip install --upgrade blinker raven \
  && apt-get -y remove python-dev build-essential gcc gfortran \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
ADD docker-entrypoint.sh /docker-entrypoint.sh
RUN chmod 755 /docker-entrypoint.sh \
 && chown root.root /docker-entrypoint.sh
