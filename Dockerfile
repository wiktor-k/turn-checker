FROM debian

RUN apt update && \
    apt install --no-install-recommends --assume-yes extrepo lua-unbound && \
    extrepo enable prosody && \
    apt update && \
    apt install --no-install-recommends --assume-yes prosody && \
    rm -rf /var/lib/apt/lists/*

COPY prosody.cfg.lua /etc/prosody/prosody.cfg.lua

CMD ["prosodyctl", "check", "turn", "-v", "--ping=stun.conversations.im"]
