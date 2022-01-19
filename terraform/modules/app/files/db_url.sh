#!/usr/bin/env bash
sudo cp -r /tmp/puma.service /lib/systemd/system/puma.service
sudo systemctl daemon-reload
sudo systemctl enable puma
sudo systemctl restart puma
