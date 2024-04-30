# 基本イメージの指定
FROM ubuntu:20.04

# 環境変数の設定
ENV DEBIAN_FRONTEND=noninteractive
ENV DISPLAY=:1

# 更新とパッケージのインストール
RUN apt-get update && apt-get install -y software-properties-common
RUN add-apt-repository ppa:obsproject/obs-studio
RUN apt-get update
RUN apt-get install -y obs-studio ffmpeg v4l2loopback-dkms x11vnc xvfb qt5-image-formats-plugins
RUN apt-get install -y python3-pip
RUN pip3 install requests

# supervisordのインストール
RUN apt-get install -y supervisor

# supervisordの設定ファイルコピー
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# マウントポイントの設定
VOLUME /media

# VNCサーバーの設定
RUN mkdir ~/.vnc
RUN x11vnc -storepasswd yourpassword ~/.vnc/passwd

# noVNCのインストール
RUN apt-get install -y novnc websockify
RUN ln -s /usr/share/novnc/vnc.html /usr/share/novnc/index.html

# 画像と音楽プレイヤーを管理するためのツールのインストール
RUN apt-get install -y imagemagick mplayer

# ポートの公開
EXPOSE 5900 6080

# エントリポイントの設定
ENTRYPOINT ["/usr/bin/supervisord"]