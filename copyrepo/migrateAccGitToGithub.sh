#!/usr/bin/env sh
# This script will create mirror of the Accenture GIT Repository i.e. copy all branches/tags to Qualcomm GIT. 
set -e
if [ "$#" -eq "0" ] || [ "$1" == "-?" ] || [ "$1" == "--help" ];then
    echo "Usage: `basename $0` <USERNAME> <PROJECT_NAME> <REPO_ NAME> <GITHUB_USERNAME>"
    echo "e.g. `basename $0` r.satti APPQ common c-rsatti"
    exit 1
fi


if [ ! -d "./${2}/${3}" ] ; then
  echo "cloning" ${3}
  git clone --mirror https://${1}@innersource.accenture.com/scm/${2}/${3}.git ./${2}/${3}
fi

  cd ./${2}/${3}
  git fetch

  git remote add dpgithub https://github.qualcomm.com/${4}/${3}.git
  git push --mirror dpgithub
