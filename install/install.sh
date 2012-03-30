#!/bin/bash

BASE_DIR="$( cd $( dirname $0 ) && pwd | awk '{gsub(/\/install/,"")}1' )"
NODE_VERSION="$( cat $BASE_DIR/install/NODE_VERSION )"

if [ ! -f /usr/local/bin/node ]; then
  echo "Node.js is not installed on yor system"
  if [ -d /home ]; then
    echo "You're using Linux. Shall I install the Ubuntu package? (yes/no)"
    read reply
    if [ "$reply" == "yes" -o "$reply" == "y" ]; then
      sudo dpkg -i $BASE_DIR/install/nodejs_$NODE_VERSION-1_i386.deb
    elif [ "$reply" == "no" -o "$reply" == "n" ]; then
      echo "Download and install Node.js for Linux from http://nodejs.org/dist/latest/node-v$NODE_VERSION.tar.gz"
      read -p "Once Node.js is installed, press any key to continue..." -n1 -s
    else
      echo "Invalid choice... exiting"
      exit 1
    fi
  elif [ -d /Volumes ]; then
    echo "Your're using Mac OS X"
    echo "Download and install Node.js from http://nodejs.org/dist/latest/node-v$NODE_VERSION.pkg"
    read -p "Once Node.js is installed, press any key to continue..." -n1 -s
  fi
fi

if [ -f /usr/local/bin/npm ]; then
  echo "Found NPM. Will now install project dependencies"
  cd $BASE_DIR
  npm -d install
else
  echo "NPM is not installed on your machine.\nPlease ensure Node.js and NPM are properly installed under /usr/local and re-run this script"
fi
