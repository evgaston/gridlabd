FROM slacgismo/circleci_gridlabd_base
ENV container docker
ENV LD_LIBRARY_PATH /usr/local/lib

VOLUME [ "/sys/fs/cgroup" ]
WORKDIR /tmp
COPY ./*.sh /tmp/

RUN sudo bash system.sh
RUN sudo bash gridlabd.sh
EXPOSE 6266-6299/tcp