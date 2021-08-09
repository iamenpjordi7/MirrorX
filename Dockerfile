FROM python:slim

WORKDIR /

ENV LD_LIBRARY_PATH /usr/local/lib

# Deps
RUN sed -i 's/main/main non-free/g' /etc/apt/sources.list && \
    apt-get -qq update && \
    apt-get -qq install -y software-properties-common curl gpg apt-utils \
    && apt-add-repository non-free \
    && echo 'deb http://download.opensuse.org/repositories/home:/nikoneko:/test/Debian_10/ /' | tee /etc/apt/sources.list.d/home:nikoneko:test.list \
    && curl -fsSL https://download.opensuse.org/repositories/home:nikoneko:test/Debian_10/Release.key | gpg --dearmor | tee /etc/apt/trusted.gpg.d/home_nikoneko_test.gpg > /dev/null \
    && apt-get -qq update \
    && apt-get -qq install -y --no-install-recommends \
        git g++ gcc autoconf automake \
                 libcurl4-openssl-dev \
                 libcrypto++-dev libsqlite3-dev libc-ares-dev \
		 libfreeimage-dev \
                 libsodium-dev \
                 libssl-dev \
                 libmagic-dev && \
    apt-get install -y tzdata curl aria2 p7zip-full p7zip-rar wget qbittorrent-nox neofetch xz-utils && \
    apt-get -y autoremove && rm -rf /var/lib/apt/lists/* && apt-get clean && \
    wget -q https://johnvansickle.com/ffmpeg/builds/ffmpeg-git-amd64-static.tar.xz && \
    tar -xf ff*.tar.xz && rm -rf *.tar.xz && \
    mv ff*/ff* /usr/local/bin/ && rm -rf ff*

RUN mv extract /usr/local/bin && \
    mv pextract /usr/local/bin && \
    chmod +x /usr/local/bin/extract && \
    chmod +x /usr/local/bin/pextract && \
    wget https://raw.githubusercontent.com/gautam1834/slam-tg-mirror-bot/master/requirements.txt \
    && pip3 install --no-cache-dir -r requirements.txt \
    && rm requirements.txt \
