FROM fedora:25

ENV PKGS="libcap-ng-utils origin-clients vim iproute wget curl tmux tmux-powerline vim-powerline \
          vim-jedi python-jedi python3-jedi vim-syntastic telnet nmap-ncat python-requests \
          python-pip"

RUN dnf erase -y vim-minimal && \
    dnf clean all && \ 
    dnf -y install --setopt=tsflags=nodocs ${PKGS} && \
    dnf clean all 

USER 1000
CMD ["/bin/true"]
