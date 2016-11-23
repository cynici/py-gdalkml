FROM debian:jessie

ARG GOSU_VERSION=1.10
ARG GOSU_DOWNLOAD_URL="https://github.com/tianon/gosu/releases/download/${GOSU_VERSION}/gosu-amd64"
ARG DEBIAN_FRONTEND=noninteractive
RUN \
  echo "deb http://httpredir.debian.org/debian jessie main" >/etc/apt/sources.list \
  && echo "deb http://httpredir.debian.org/debian jessie-updates main" >>/etc/apt/sources.list \
  && echo "deb http://security.debian.org/ jessie/updates main" >>/etc/apt/sources.list  \
  && apt-get update \
  && apt-get -y --force-yes --no-install-recommends --fix-missing install python-pip python-psycopg2  python-yaml libgeos-c1 libxml2-dev build-essential gcc python-dev libblas-dev liblapack-dev libatlas-base-dev gfortran \
  && apt-get -y install python-numpy python-scipy python-matplotlib ipython ipython-notebook python-pandas python-sympy python-nose curl \
  && apt-get update \
  && apt-get -y dist-upgrade \
  && curl -o gosu -fsSL "$GOSU_DOWNLOAD_URL" > /tmp/gosu \
  && mv /tmp/gosu /usr/bin/gosu \
  && chmod +x /usr/bin/gosu \
  && pip install --upgrade pip \
  && pip install simplekml flask reverse_geocoder python-dateutil uwsgi \
  && apt-get -y remove python-dev build-essential gcc gfortran \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
