# 既存のコンテナ、イメージ、未使用のボリューム、ネットワークを削除
sudo docker container prune -f
sudo docker image prune -a -f
sudo docker volume prune -f
sudo docker network prune -f
sudo docker system prune -a -f

# 新しいイメージのビルド
sudo docker build --no-cache -t obs-studio-vnc .

# 新しいコンテナの起動
sudo docker run -d --restart=always -p 5900:5900 -p 1935:1935 -p 6080:6080 -v /media:/media obs-studio-vnc