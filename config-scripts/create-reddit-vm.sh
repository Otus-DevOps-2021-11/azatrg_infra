#!/usr/bin/env bash
 yc compute instance create \
  --name reddit-app \
  --hostname reddit-app \
  --core-fraction 50 \
  --memory=2 \
  --create-boot-disk image-family=reddit-app,size=10GB \
  --network-interface subnet-name=default-ru-central1-a,nat-ip-version=ipv4 \
  --metadata serial-port-enable=1 \
  --ssh-key ~/.ssh/appuser.pub
