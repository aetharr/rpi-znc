FROM resin/rpi-raspbian:wheezy

MAINTAINER AEtharr <aetharr@gmail.com>

# Prepare the Image for building ZNC from source
RUN apt-get update && \
    apt-get install -y build-essential && \
    apt-get install -y wget && \
    apt-get install -y libicu-dev && \
    apt-get install -y pkg-config && \
    apt-get install -y g++-4.7 && \
    apt-get install -y libssl-dev && \
    update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-4.6 60 --slave /usr/bin/g++ g++ /usr/bin/g++-4.6 && \
    update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-4.7 40 --slave /usr/bin/g++ g++ /usr/bin/g++-4.7 && \
    update-alternatives --set gcc /usr/bin/gcc-4.7 && \
    wget http://znc.in/releases/znc-latest.tar.gz && \
    tar -zxf znc-latest.tar.gz && \
    cd znc* && \
    ./configure && make && make install && \
    apt-get remove --auto-remove -y build-essential && \
    apt-get remove --auto-remove -y pkg-config && \
    apt-get remove --auto-remove -y g++-4.7 && \
    apt-get remove --auto-remove -y libssl-dev && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \

    useradd --create-home --shell /bin/bash znc

# Copy in our default config and startup script
COPY ./files/start-znc.sh /usr/local/bin/
COPY ./files/default.conf /home/znc/

# Make sure that the ZNC user has permission to use the config
RUN chown znc:znc /home/znc/default.conf

# Actually create the .znc folder with relative permissions
RUN mkdir -p /home/znc/.znc && \
    chown znc:znc -Rf /home/znc/.znc

USER znc

WORKDIR /home/znc

ENTRYPOINT ["/usr/local/bin/start-znc.sh"]

EXPOSE 8080
