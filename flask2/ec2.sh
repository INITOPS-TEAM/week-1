#!/bin/bash

sudo apt update -y
sudo apt install docker.io -y

sudo systemctl start docker
sudo systemctl enable docker

docker pull mstr12/flaskproject:flask2

docker run -d -p 5001:5000 mstr12/flaskproject:flask2