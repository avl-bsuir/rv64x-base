FROM ubuntu:20.10 AS rv64x-dev
MAINTAINER Abel Bernabeu <abel.bernabeu@gmail.com>

RUN \
   apt clean \
   apt autoclean \
   apt update

RUN apt-get update

# Install all needed ubuntu packages
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y --fix-missing\
  sudo \
  openssh-server \
  vim \
  git \
  npm libnss3 libatk-adaptor cups libgdm-dev gnome \
  python3 cmake

# Add "user" and "root" users
RUN useradd -m user -s /bin/bash
RUN yes user | passwd user
RUN adduser user sudo
RUN echo "sshd : ALL : allow" > /etc/hosts.allow
RUN (echo "root" ; echo "root") | passwd root

# Create repo directory
RUN runuser -l user -c "cd /home/user ; mkdir repo"

# Setup the .bash_profile
RUN runuser -l user -c "echo \"# Colorize the ls output\" >> /home/user/.bash_profile"
RUN runuser -l user -c "echo \"alias ls='ls --color=auto'\" >> /home/user/.bash_profile"
RUN runuser -l user -c "echo >> /home/user/.bash_profile"
RUN runuser -l user -c "echo \"# Use a long listing format\" >> /home/user/.bash_profile"
RUN runuser -l user -c "echo \"alias ll='ls -la'\" >> /home/user/.bash_profile"
RUN runuser -l user -c "echo >> /home/user/.bash_profile"
RUN runuser -l user -c "echo \"# Show hidden files\" >> /home/user/.bash_profile"
RUN runuser -l user -c "echo \"alias l.='ls -d .* --color=auto'\" >> /home/user/.bash_profile"
RUN runuser -l user -c "echo >> /home/user/.bash_profile"
RUN runuser -l user -c "echo \"# Move to the repo directory\" >> /home/user/.bash_profile"
RUN runuser -l user -c "echo 'cd /home/user/repo' >> /home/user/.bash_profile"
RUN runuser -l user -c "echo >> /home/user/.bash_profile"
RUN runuser -l user -c "echo \"# X11 connection\" >> /home/user/.bash_profile"
RUN runuser -l user -c "echo 'export DISPLAY=:1' >> /home/user/.bash_profile"

# Get RISC-V V spec sources
RUN runuser -l user -c "cd /home/user ; git clone https://github.com/riscv/riscv-v-spec"
RUN runuser -l user -c "cd /home/user/riscv-v-spec ; npm i"

# Export ports
EXPOSE 22

ENTRYPOINT \
  service ssh start && \
  login -f user
