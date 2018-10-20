#!/usr/bin/env sh
# This script will create mirror of the source GIT Repository REFERENCES i.e. copy all branches/tags REFERENCES to CLIENT GIT. 

# PREREQUISITE: git should be installed using $sudo yum install git -y
set -e 
if [ "$#" -eq "0" ] || [ "$1" == "-?" ] || [ "$1" == "--help" ];then
    echo "Usage: `basename $0` <USERNAME> <PROJECT_NAME> <REPO_ NAME> <GITHUB_USERNAME>"
    echo "e.g. `basename $0` r.satti APPQ common c-rsatti"
    exit 1
fi

# https://stackoverflow.com/questions/12806176/checking-for-installed-packages-and-if-not-found-install
sudo rpm --quiet --query git || yum install -y git

if [ ! -d "./${2}/${3}" ]; then
  echo "cloning" ${3}
  git clone --mirror https://${1}@innersource.<SOURCE_GIT>.com/scm/${2}/${3}.git ./${2}/${3}
fi

  cd ./${2}/${3}
  git fetch

  git remote set-url dpgithub https://github.<CLIENT_GIT>.com/${4}/${3}.git
  git push --mirror dpgithub
