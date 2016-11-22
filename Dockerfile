FROM debian:jessie

#
# Workaround for repeated Failed to fetch from httpredir.debian.org ... Remote end closed during docker build
#
# Obtained from manually test http://httpredir.debian.org/demo.html
#
ARG DEBIAN_FRONTEND=noninteractive
RUN \
  echo "deb http://ftp.uk.debian.org/debian jessie main" >/etc/apt/sources.list \
  && echo "deb http://ftp.uk.debian.org/debian jessie-updates main" >>/etc/apt/sources.list \
  && echo "deb http://mirror.cse.unsw.edu.au/debian-security jessie/updates main" >>/etc/apt/sources.list  \
  && apt-get update \
  && apt-get -y upgrade \
  && apt-get -y --force-yes --no-install-recommends --fix-missing install python-pip python-psycopg2  python-yaml libgeos-c1 libxml2-dev build-essential gcc python-dev libblas-dev liblapack-dev libatlas-base-dev gfortran \
  && apt-get -y install python-numpy python-scipy python-matplotlib ipython ipython-notebook python-pandas python-sympy python-nose \
  && pip install --upgrade pip \
  && pip install simplekml flask reverse_geocoder python-dateutil uwsgi \
  && apt-get -y remove python-dev build-essential gcc \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
