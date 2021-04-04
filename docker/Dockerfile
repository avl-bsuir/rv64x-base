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
  python3 cmake \
  ninja-build libpixman-1-dev


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

# Get QEMU sources
RUN runuser -l user -c "cd /home/user ; git clone https://github.com/qemu/qemu"

# Patch QEMU sources
COPY qemu-patch /home/user/qemu/patch
RUN runuser -l user -c "cd /home/user/qemu; git apply patch"

# Build QEMU
RUN runuser -l user -c "mkdir -p /home/user/qemu/build"
RUN runuser -l user -c "cd /home/user/qemu/build ; ../configure"
RUN runuser -l user -c "cd /home/user/qemu/build ; make -j10"

# Install Ubuntu packages needed by buildroot
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y --fix-missing\
  rsync cpio

# Get buildroot sources and build the image for QEMU
RUN runuser -l user -c "cd /home/user ; git clone https://github.com/buildroot/buildroot.git"
RUN runuser -l user -c "cd /home/user/buildroot ; make qemu_riscv64_virt_defconfig"
RUN runuser -l user -c "cd /home/user/buildroot ; make -j10"

# Install Ubuntu packages needed for running buildroot "make menuconfig"
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y --fix-missing\
  libncurses-dev

# Replace buildroot's QEMU with the one we built ourselves
RUN runuser -l user -c "sed -i 's/buildroot\/output\/host\/bin/qemu\/build/g' /home/user/buildroot/output/images/start-qemu.sh"

# Install e2tools Ubuntu package for copying from docker image to QEMU image
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y --fix-missing\
  e2tools

# Install xfce4 and tightvncserver
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y --fix-missing\
  xfce4 xfce4-goodies tightvncserver libxrandr-dev xfce4-terminal

# Setup the .bash_profile
RUN runuser -l user -c "mkdir /home/user/.vnc"
RUN runuser -l user -c "echo \"#!/bin/bash\" >> /home/user/.vnc/xstartup"
RUN runuser -l user -c "echo \"/usr/bin/xrdb /home/user/.Xresources\" >> /home/user/.vnc/xstartup"
RUN runuser -l user -c "echo \"while : ; do xfce4-session ; sleep 1 ; done \" >> /home/user/.vnc/xstartup"
RUN runuser -l user -c "chmod +x /home/user/.vnc/xstartup"

# Export ports
EXPOSE 22
EXPOSE 5900
EXPOSE 5901

ENTRYPOINT \
  service ssh start && \
  login -f user
