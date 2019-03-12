# SiLK Sandbox
#
# VERSION	2.1.1
# Copyright 2016 Carnegie Mellon University
# This material is based upon work funded and supported by Flocon - which is funded by Cost Recovery Dollars under Contract No. FA8721-05-C-0003 with Carnegie Mellon University for the operation of the Software Engineering Institute, a federally funded research and development center sponsored by the United States Department of Defense.
# Any opinions, findings and conclusions or recommendations expressed in this material are those of the author(s) and do not necessarily reflect the views of Flocon - which is funded by Cost Recovery Dollars or the United States Department of Defense.
# NO WARRANTY. THIS CARNEGIE MELLON UNIVERSITY AND SOFTWARE ENGINEERING INSTITUTE MATERIAL IS FURNISHED ON AN “AS-IS” BASIS. CARNEGIE MELLON UNIVERSITY MAKES NO WARRANTIES OF ANY KIND, EITHER EXPRESSED OR IMPLIED, AS TO ANY MATTER INCLUDING, BUT NOT LIMITED TO, WARRANTY OF FITNESS FOR PURPOSE OR MERCHANTABILITY, EXCLUSIVITY, OR RESULTS OBTAINED FROM USE OF THE MATERIAL. CARNEGIE MELLON UNIVERSITY DOES NOT MAKE ANY WARRANTY OF ANY KIND WITH RESPECT TO FREEDOM FROM PATENT, TRADEMARK, OR COPYRIGHT INFRINGEMENT.
# [Distribution Statement A] This material has been approved for public release and unlimited distribution. Please see Copyright notice for non-US Government use and distribution.
# DM-0004288
FROM ubuntu
MAINTAINER Matt Heckathorn <maheckathorn@cert.org>

# Specify container username (e.g. training, demo)
ENV VIRTUSER demo

# Specify software versions to download
ARG SILK_VERSION=3.18.0
ARG FIXBUF_VERSION=2.2.0
ARG NETSA_PYTHON_VERSION=1.5
ARG PYFIXBUF_VERSION=0.6.0
ARG RAYON_VERSION=1.4.3
ARG YAF_VERSION=2.10.0
ARG SUPER_VERSION=1.6.0
ARG PIPELINE_VERSION=4.5.1

# Set noninteractive mode for build only
ARG DEBIAN_FRONTEND=noninteractive

# Install software pre-reqs
RUN apt-get update && apt-get install -y --no-install-recommends \
		bison \
		build-essential \
		cmake \
		curl \
		emacs \
		flex \
		g++ \
		gawk \
		gcc \
		glib2.0 \
		less \
		libcairo2-dev \
		libglib2.0-dev \
		liblzo2-2 \
		liblzo2-dev \
		libmysqlclient-dev \
		libpcap-dev \
		libprotobuf-c-dev \
		libyaml-dev \
		make \
		man-db \
		mysql-client \
		mysql-server \
		nano \
		netcat \
		python-cairo \
		python-dev \
		python-scapy \
		r-base \
		screen \
		tcpdump \
		tmux \
		vim \
		wget \
        sqlite3 \
		iputils-ping \
		&& apt-get clean \
		&& rm -rf /var/lib/apt/lists/*
RUN adduser --disabled-password --gecos "" $VIRTUSER

# Download & Install latest silk-y stuff
RUN curl https://tools.netsa.cert.org/releases/libfixbuf-$FIXBUF_VERSION.tar.gz | tar -xz && cd libfixbuf-* && ./configure && make && make install && cd ../ && rm -rf libfixbuf-$FIXBUF_VERSION
RUN curl https://tools.netsa.cert.org/releases/silk-$SILK_VERSION.tar.gz | tar -xz && cd silk-* && ./configure --with-python --enable-ipv6 --enable-data-rootdir=/data/ && make && make install && cd ../ && rm -rf silk-$SILK_VERSION
ENV LD_LIBRARY_PATH=/usr/local/lib
RUN curl https://tools.netsa.cert.org/releases/netsa-python-$NETSA_PYTHON_VERSION.tar.gz | tar -xz && cd netsa-python-* && python setup.py install && cd ../ && rm -rf netsa-python-$NETSA_PYTHON_VERSION
RUN curl https://tools.netsa.cert.org/releases/pyfixbuf-$PYFIXBUF_VERSION.tar.gz | tar -xz && cd pyfixbuf-* && python setup.py build && python setup.py install && cd ../ && rm -rf pyfixbuf-$PYFIXBUF_VERSION
RUN curl https://tools.netsa.cert.org/releases/rayon-$RAYON_VERSION.tar.gz | tar -xz && cd rayon-* && python setup.py install && cd ../ && rm -rf rayon-$RAYON_VERSION
RUN curl https://tools.netsa.cert.org/releases/yaf-$YAF_VERSION.tar.gz | tar -xz && cd yaf-* && ./configure && make && make install && cd ../ && rm -rf yaf-$YAF_VERSION
RUN curl https://tools.netsa.cert.org/releases/super_mediator-$SUPER_VERSION.tar.gz | tar -xz && cd super_mediator-* && ./configure --with-mysql && make && make install && cd ../ && rm -rf super_mediator-$SUPER_VERSION
# Run ldconfig to create necessary links to shared libraries so pipeline works.
RUN su -l -c "ldconfig"
RUN curl https://tools.netsa.cert.org/releases/analysis-pipeline-$PIPELINE_VERSION.tar.gz | tar -xz && cd analysis-pipeline-* && ./configure --with-silk-config=/usr/local/bin/silk_config && make && make install && cd ../ && rm -rf analysis-pipeline-$PIPELINE_VERSION
# Create country code file for pipeline
RUN wget -nc -O /tmp/GeoLite2-Country-CSV.zip http://geolite.maxmind.com/download/geoip/database/GeoLite2-Country-CSV.zip && unzip -j /tmp/GeoLite2-Country-CSV.zip -d /tmp/GeoLite2-Country-CSV && rwgeoip2ccmap --input-path=/tmp/GeoLite2-Country-CSV --output-path=/usr/local/share/silk/country_codes.pmap && rm -rf /tmp/GeoLite2-Country-CSV /tmp/GeoLite2-Country-CSV.zip
