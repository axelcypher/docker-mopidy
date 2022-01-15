FROM debian:buster-slim
RUN export DEBIAN_FRONTEND=noninteractive && \
    apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y -f \
       build-essential \
       gettext \
       openssl \
       software-properties-common \
       apt-transport-https \
       gstreamer1.0-plugins-bad \
       curl \
       nano \
       git \
       gnupg2 \
       python3 \
       python3-pip
RUN curl -k "https://apt.mopidy.com/mopidy.gpg" | apt-key add -
RUN curl -k "https://apt.mopidy.com/buster.list" > /etc/apt/sources.list.d/mopidy.list
RUN apt-get update && \
    apt-get install -y -f \
       mopidy \
       mopidy-spotify \
       mopidy-local \
       mopidy-local-sqlite \
       mopidy-mpd \
       mopidy-podcast \
       mopidy-podcast-itunes \
       mopidy-scrobbler \
       mopidy-somafm \
       mopidy-soundcloud \
       mopidy-tunein
RUN python3 -m pip install git+https://github.com/natumbri/mopidy-youtube.git
RUN python3 -m pip install Mopidy-YTMusic
RUN python3 -m pip install Mopidy-Iris
RUN python3 -m pip install Mopidy-Party

RUN curl -L https://github.com/yt-dlp/yt-dlp/releases/latest/download/yt-dlp -o /usr/local/bin/yt-dlp \
    && chmod a+rx /usr/local/bin/yt-dlp

RUN mkdir -p /data/music
EXPOSE 6680 6600
CMD ["/usr/bin/mopidy"]
