#!/bin/bash

sets=(
    "2.11.10 rockylinux:8 arg1_3"
    "2.12.10 rockylinux:9 arg1_3"
    "2.13.0 rockylinux:9 arg1_3"
    "2.14.0 rockylinux:9 arg1_3"
    "2.15.0 fedora:40 arg1_3"
    "2.16.0 fedora:40 arg1_3"
)

for set in "${sets[@]}"; do

  read -r ver image arg3 <<< "$set"

  printf "testing ansible version %s with image %s\n" $ver $image

  docker build . \
    --build-arg MYAPP_IMAGE=$image \
    --build-arg ANSIBLE_VERSION=$ver \
    -t test1-$ver

  docker run --rm -it test1-$ver bash -c "ANSIBLE_COMMAND_WARNINGS=false ANSIBLE_DEPRECATION_WARNINGS=false ANSIBLE_PYTHON_INTERPRETER=auto_silent ANSIBLE_STDOUT_CALLBACK=community.general.dense ansible-playbook playbook.yml"

done
