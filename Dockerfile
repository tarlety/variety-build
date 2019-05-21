FROM python:3.7.3-stretch

RUN apt-get update -y && apt-get upgrade -y
RUN apt-get install build-essential -y

RUN apt-get install devscripts dh-make debhelper fakeroot -y
RUN apt-get install debhelper dh-python python3-distutils-extra -y

VOLUME /packages/variety/deb
VOLUME /packages/variety/src
VOLUME /secret

RUN mkdir -p /packages/variety/deb
COPY variety /packages/variety/src

WORKDIR /packages/variety/src
CMD ["/bin/bash", "-c", "gpg --import /secret/key.sec && debuild -S -sa && mv ../variety_* ../deb"]
