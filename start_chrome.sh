#!/bin/bash

#dict
declare -A arr
arr=([lam]=8 [vinh]=15 [trinh]=14 [quangnguyen]=19 [phisbi]=17 [tubui]=26 [trieu]=27 [quan]=28 [nhatquang]=29 [nhan]=31 [phuc]=32 [thinh]=34)

for i in "${!arr[@]}"
do
    echo "$i - ${arr[$i]}"
done | column -t | sort 

read -p "type your google profile number: " profile
google-chrome --profile-directory="Profile $profile" --restore-last-session --ignore-ssl-errors --ignore-certificate-errors-spki-list
