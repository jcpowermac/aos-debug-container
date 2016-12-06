FROM fedora:25

ENV PKGS="libcap-ng-utils origin-clients vim iproute wget curl tmux tmux-powerline vim-powerline \
          vim-jedi python-jedi python3-jedi vim-syntastic telnet nmap-ncat python-requests \
          python-pip nss_wrapper findutils gettext"
COPY user_setup /tmp/
RUN dnf erase -y vim-minimal && \
    dnf clean all && \ 
    dnf -y install --setopt=tsflags=nodocs ${PKGS} && \
    dnf clean all 

ENV APP_ROOT=/home/user \
    USER_NAME=user \
    USER_UID=10001
ENV APP_HOME=${APP_ROOT}/src  PATH=$PATH:${APP_ROOT}/bin
RUN mkdir -p ${APP_HOME} ${APP_ROOT}/etc
COPY bin/ ${APP_ROOT}/bin/
RUN chmod -R ug+x ${APP_ROOT}/bin ${APP_ROOT}/etc /tmp/user_setup && \
    /tmp/user_setup

USER ${USER_UID}
WORKDIR ${APP_ROOT}

RUN sed "s@${USER_NAME}:x:${USER_UID}:0@${USER_NAME}:x:\${USER_ID}:\${GROUP_ID}@g" /etc/passwd > ${APP_ROOT}/etc/passwd.template
ENTRYPOINT [ "nss_entrypoint" ]
CMD run
