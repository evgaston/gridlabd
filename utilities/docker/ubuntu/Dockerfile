FROM ubuntu:xenial
ENV container docker
ENV LD_LIBRARY_PATH /usr/local/lib

VOLUME [ "/sys/fs/cgroup" ]
WORKDIR /tmp
COPY ./*.sh /tmp/

RUN bash system.sh
RUN bash gridlabd.sh
EXPOSE 6266-6299/tcp