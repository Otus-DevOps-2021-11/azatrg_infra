#!/usr/bin/env bash
apt install -y git
useradd puma
mkdir /opt/app && cd /opt/app && git clone -b monolith https://github.com/express42/reddit.git
chown -R puma:puma /opt/app/reddit/
cd reddit && bundle install
wget https://gist.githubusercontent.com/azatrg/c2b02fb8f4c89722cb3885c84a832a97/raw/952b1ece89ef300d30f103a41a8ed34596694776/puma.service
cp ./puma.service /lib/systemd/system/puma.service
systemctl daemon-reload
systemctl start puma
systemctl enable puma
