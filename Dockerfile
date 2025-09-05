FROM ubuntu:22.04
LABEL \
    org.opencontainers.image.title="Redis 7.2.10" \
    org.opencontainers.image.vendor="Ubuntu22 build system" \
    org.opencontainers.image.licenses="Apache" \
    org.opencontainers.image.created="2025-04-09" \
    maintainer="slackman.cn"

ENV DEBIAN_FRONTEND=noninteractive \
    TZ=Asia/Shanghai \
    LANG=en_US.UTF8 \
    LC_ALL=en_US.UTF8 \
    LANGUAGE=enUS:en \
    PATH="/usr/local/go/bin:/bin:/usr/bin:/sbin:/usr/sbin:/usr/local/bin:/usr/local/sbin"

# init system
ADD sources.list /etc/apt/sources.list
RUN apt-get update && apt-get install -y --no-install-recommends tzdata language-pack-en \
    && ln -snf /usr/share/zoneinfo/$TZ /etc/localtime  \
    && echo $TZ > /etc/timezone \
    && dpkg-reconfigure -f noninteractive tzdata

# Install build base
RUN apt-get install --no-install-recommends --yes \
    nano less git wget curl \
    ca-certificates \
    build-essential \
    dpkg-dev \
    libc6-dev \
    libssl-dev \
    pkg-config \
    tcl


WORKDIR /build
COPY build ./

CMD ["bash"]