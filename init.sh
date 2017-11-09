#!/bin/bash

echo "Checking yarn"

file=./package.json
apps=./apps.txt

if yarn --version > /dev/null; then
  echo "yarn is already installed."
  if [ -e "$file" ]; then
    echo "File - package.json - exists"
    if [ -e "$apps" ]; then
      echo "File - apps.txt - exists"
      while read -r line
      do
        app=`echo $line | cut -d \; -f 1`
        yarn add $app --dev
      done < $apps
    else
      echo "File not exists"
    fi
  else
    echo "File not exists"
    yarn init
  fi
else
  echo "installing yarn."
  echo "operation system package manager check"
  if yum -v > /dev/null; then
    echo "installing yarn with yum"
    echo "get the RPM Package Repository"
    sudo wget https://dl.yarnpkg.com/rpm/yarn.repo -O /etc/yum.repos.d/yarn.repo
    echo "install the package"
    sudo yum install yarn
  else
    echo "yum is not installed"
  fi
  if pacman -v > /dev/null; then
    echo "installing yarn with pacman"
    pacman -S yarn
  else
    echo "pacman is not installed"
  fi
  if zypper -v > /dev/null; then
    echo "installing yarn with zypper"
    echo "get the RPM Package Repository"
    sudo zypper ar -f https://dl.yarnpkg.com/rpm/ Yarn
    echo "install the package"
    sudo zypper in yarn
  else
    echo "zypper is not installed"
  fi
  if apt-get -V > /dev/null; then
    echo "installing yarn with apt-get"
    echo "get the package and key for this software"
    curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
    echo "update system and install the package"
    sudo apt-get update && sudo apt-get install yarn
  else
    echo "apt-get is not installed"
  fi
  if port version > /dev/null; then
    echo "installing yarn with port"
    sudo port install yarn
  else
    echo "port is not installed"
  fi
  if brew --version > /dev/null; then
    echo "installing yarn with brew"
    brew install yarn
  else
    echo "brew is not installed"
  fi
fi
