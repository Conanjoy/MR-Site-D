#!/bin/bash

python3 ms_rewards_farmer.py --everyday 04:00 --headless --fast --privacy
apt-get --only-upgrade install google-chrome-stable