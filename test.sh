#!/bin/bash

set -euo pipefail

sets=(
    "2.11.0 rockylinux:8"
    "2.12.0 rockylinux:9"
    "2.13.0 rockylinux:9"
    "2.14.0 rockylinux:9"
    "2.15.0 fedora:40"
    "2.16.0 fedora:40"
    "2.17.0 fedora:40"
)

for set in "${sets[@]}"; do

  read -r ver image <<< "$set"

  printf "testing ansible version %s with image %s\n" $ver $image

  docker build -q . \
    --build-arg MYAPP_IMAGE=$image \
    --build-arg ANSIBLE_VERSION=$ver \
    -t test1-$ver

  docker run --rm -it test1-$ver bash -c "ansible-playbook playbook.yml" || printf "test failed\n"

done
