#! /bin/bash

source ~/.nvm/nvm.sh
cd ~ && mkdir workspace
cd ~/c9sdk
node server.js -p 3000 -a : -w '/root/workspace/' --listen 0.0.0.0
