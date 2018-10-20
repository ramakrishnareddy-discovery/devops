#!/bin/bash
# THIS SCRIT SHOWS COMMA SEPARATED VALUES ITERATION
set -e
if [ "$#" -eq "0" ] || [ "$1" == "-?" ] || [ "$1" == "--help" ];then
    echo "Usage: `basename $0` <comma separated values>"
    echo "e.g. `basename $0` 45, 2, rk, 5aku"
    exit 1
fi

for i in $(echo ${1} | sed "s/,/ /g");do
    # call your procedure/other scripts here below
    echo "$i"
done