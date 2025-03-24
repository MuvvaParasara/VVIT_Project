#!/bin/bash

# Update the package list
sudo yum update -y

# Install Python 3 and pip
sudo yum install -y python3

# Verify the installation
python3 --version
pip3 --version

# Optionally, set Python 3 as the default python
sudo alternatives --install /usr/bin/python python /usr/bin/python3 1
sudo alternatives --set python /usr/bin/python3

# Install Git
sudo yum install -y git

# Verify Git installation
git --version

# Verify default Python version
python --version

# Download Codebase
cd ~/
git clone https://github.com/mohanasan/VVIT-2.6---Copy.git
