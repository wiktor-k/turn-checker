FROM debian

# workaround for build issue on aarch64
# see: https://github.com/docker/buildx/issues/495#issuecomment-995503425
RUN ln -s /usr/bin/dpkg-split /usr/sbin/dpkg-split && \
    ln -s /usr/bin/dpkg-deb /usr/sbin/dpkg-deb && \
    ln -s /bin/tar /usr/sbin/tar && \
    ln -s /bin/rm /usr/sbin/rm

RUN apt update && \
    apt install --no-install-recommends --assume-yes extrepo lua-unbound && \
    extrepo enable prosody && \
    apt update && \
    apt install --no-install-recommends --assume-yes prosody && \
    rm -rf /var/lib/apt/lists/*

COPY prosody.cfg.lua /etc/prosody/prosody.cfg.lua

CMD ["prosodyctl", "check", "turn", "-v", "--ping=stun.conversations.im"]
