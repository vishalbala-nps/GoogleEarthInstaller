#!/bin/bash

sudo -v

for i in "wget" "dpkg" "apt"
do
  which $i > /dev/null
  if [ $? -ne 0 ]; then
    echo "$i is not available in the path. Please check and try again"
    exit 1
  fi
done

echo "Welcome to the Google Earth Pro Installer Script. This script will help you install Google Earth Pro on your Ubuntu/Debian Linux computer"
read -p "Would you like to continue? [y/n]: " yn

if [ "$yn" = "y" ]; then
  echo "Installing required dependencies..."
  apt install -y lsb-core
  if [ $? -eq 0 ]; then
    echo
    echo "Installed required dependencies"
  else 
    echo
    echo "An error Occured while downloading dependencies. Please check the error messages, fix the problems and try again"
    exit 1
  fi
  dname=`mktemp -d`
  cd $dname
  if [ `uname -m` = "x86_64" ]; then
    echo
    echo "Detected system architecture as 64-Bit"
    echo "Downloading the 64-Bit version of Google Earth Pro"
    echo
    wget "https://dl.google.com/dl/earth/client/GE7/release_7_3_0/google-earth-pro-stable_7.3.0.3832-r0_amd64.deb"
    if [ $? -eq 0 ]; then
      echo
      echo "Successfully Downloaded"
    else 
      echo
      echo "An error Occured while downloading. Please check your internet connection and try again"
      cd ..
      rm -rf $dname
      exit 1
    fi
  else
    echo
    echo "Detected system architecture as 32-Bit"
    echo "Downloading the 32-Bit version of Google Earth Pro"
    echo
    wget "https://dl.google.com/dl/earth/client/GE7/release_7_3_0/google-earth-pro-stable_7.3.0.3832-r0_i386.deb"
    if [ $? -eq 0 ]; then
      echo
      echo "Successfully Downloaded"
    else 
      echo
      echo "An error Occured while downloading. Please check your internet connection and try again"
      cd ..
      rm -rf $dname
      exit 1
    fi
  fi
  echo
  echo "Installing Google Earth Pro"
  echo
  dpkg -i *.deb
  if [ $? -eq 0 ]; then
    echo
    echo "Installed Google Earth Pro"
  else 
    echo
    echo "An error Occured while running dpkg. Please check the dpkg error message, fix the problems and try again"
    cd ..
    rm -rf $dname
    exit 1
  fi
  echo "Successfully Installed Google Earth Pro! You can launch it through your application menu or by typing google-earth-pro in the terminal"  
  cd ..
  rm -rf $dname
  exit 0
else
  echo "Aborting.. Goodbye"
  exit 1
fi
