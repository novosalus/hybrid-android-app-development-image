FROM novosalus/adoptopenjdk-android-nodejs:focal-jdk-11

ARG BUILD_DATE
ARG BUILD_VERSION
ARG VCS_REF

LABEL maintainer="Ritesh Chaudhari <ritesh@novosalus.com>" \
      org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.version=$BUILD_VERSION \
      org.label-schema.vcs-ref=$VCS_REF \
      org.label-schema.schema-version="1.0" \
      org.label-schema.vcs-url="https://github.com/novosalus/hybrid-android-app-development-image.git" \
      org.label-schema.name="novosalus/hybrid-android-app-development" \
      org.label-schema.vendor="Ritesh Chaudhari (Novosalus)" \
      org.label-schema.description="Hybrid android app development docker image" \
      org.label-schema.url="https://novosalus.com/" \
      org.label-schema.license="" \
      org.opencontainers.image.title="novosalus/hybrid-android-app-development" \
      org.opencontainers.image.description="Hybrid android app development docker image" \
      org.opencontainers.image.licenses="" \
      org.opencontainers.image.authors="Ritesh Chaudhari" \
      org.opencontainers.image.vendor="Ritesh Chaudhari" \
      org.opencontainers.image.url="https://hub.docker.com/r/novosalus/hybrid-android-app-development" \
      org.opencontainers.image.documentation="" \
      org.opencontainers.image.source="https://github.com/novosalus/hybrid-android-app-development-image.git"
      

ARG CORDOVA_VERSION
ENV CORDOVA_VERSION=${CORDOVA_VERSION:-11.0.0}

ENV DEBIAN_FRONTEND=noninteractive

#install ruby(to install fastlane), imagemagick, inkscape

RUN rm -rf /var/lib/apt/lists/* && \
    apt-get -y -q update && \
    apt-get -y install libz-dev libiconv-hook1 libiconv-hook-dev build-essential ruby-full imagemagick inkscape

# install fastlane
RUN gem install fastlane -NV

# dependancies required for cypress test framework
RUN apt-get -y install libgtk2.0-0 libgtk-3-0 libgbm-dev libnotify-dev libgconf-2-4 libnss3 libxss1 libasound2 libxtst6 xauth xvfb

# install cordova
RUN npm i -g --unsafe-perm cordova@${CORDOVA_VERSION}

# install rclone to store/retrieve artifacts like generated apks,aab and screenshots etc. keep rclone.conf file in
RUN curl https://rclone.org/install.sh | bash

WORKDIR "/home/ubuntu/app"