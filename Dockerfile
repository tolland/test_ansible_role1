ARG MYAPP_IMAGE=rockylinux:8
FROM $MYAPP_IMAGE

# Install
RUN set -eux; \
  \
  dnf install -y \
    python3 \
    python3-pip ; \
    pip3 install --upgrade pip;

WORKDIR /app

ARG ANSIBLE_VERSION=2.11.10

RUN set -eux; \
    pip install ansible-core~=$ANSIBLE_VERSION ansible

COPY role /app/role
COPY playbook.yml /app

