#!/usr/bin/env bash
sudo cp /tmp/mongod.conf /etc/mongod.conf
sudo chown root:root /etc/mongod.conf
sudo systemctl restart mongod
