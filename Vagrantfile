# -*- mode: ruby -*-
# vi: set ft=ruby :

require 'yaml'
settings = YAML.load_file 'settings.yml'

Vagrant.configure(2) do |config|
  config.vm.provider "vmware_workstation"
  config.vm.provider "virtualbox"

  config.vm.box = "ubuntu/focal64"
  config.vm.hostname = settings['name']
  config.ssh.insert_key = true
  config.disksize.size = settings['disk_size']
  # remove the 'ip' parameter for dhcp
  # uncomment the line below for bridged networking
  config.vm.network "public_network", ip: settings['ip_address']

  config.vm.provider "vmware_workstation" do |vb|
      vb.name = settings['name']
      vb.cpus = settings['cpus']
      vb.memory = settings['ram']
  end

  config.vm.provider "virtualbox" do |vb|
      vb.name = settings['name']
      vb.cpus = settings['cpus']
      vb.memory = settings['ram']
  end



  # basic tools
  config.vm.provision "shell", inline: <<-SHELL
    sudo apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y \
    clang \
    cmake \
    protobuf-compiler \
    flex \
    bison \
    git \
    gcc \
    gdb \
    iproute2 \
    jq \
    libncurses5 \
    lldb-3.9 \
    openssh-server \
    rsync \
    unzip \
    yamllint \
    vim \
    make \
    build-essential \
    valgrind \
    wget \
    zsh \
    python-dev \
    python3-dev \
    python3-venv \
    python3-pip \
    htop \
    apt-transport-https \
    software-properties-common \
    net-tools 
      SHELL

    
    
    # Go install
    config.vm.provision "shell", inline: <<-SHELL
      wget https://golang.org/dl/go1.16.4.linux-amd64.tar.gz && \
      tar -xvf go1.16.4.linux-amd64.tar.gz && \
      sudo mv go /usr/local 
      # export GOROOT=/usr/local/go && \
      # export PATH=$PATH:$GOROOT/bin 
        SHELL
  
  # Helm install
  config.vm.provision "shell", inline: <<-SHELL
    curl https://baltocdn.com/helm/signing.asc | sudo apt-key add - && \
    echo "deb https://baltocdn.com/helm/stable/debian/ all main" | sudo tee /etc/apt/sources.list.d/helm-stable-debian.list && \
    DEBIAN_FRONTEND=noninteractive apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install helm
      SHELL

  # Docker Install
  config.vm.provision "shell", inline: <<-SHELL
    DEBIAN_FRONTEND=noninteractive apt-get update && \
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add - && \
    add-apt-repository \
    "deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable" && \
    DEBIAN_FRONTEND=noninteractive apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y \
        containerd.io \
        docker-ce \
        docker-ce-cli \
        docker-compose && \
    usermod -aG docker vagrant && newgrp docker
      SHELL
  
  # minikube install
  config.vm.provision "shell", inline: <<-SHELL
    curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64 && \
    sudo install minikube-linux-amd64 /usr/local/bin/minikube 
    # minikube start --network-plugin=cni
      SHELL

  config.vm.provision "shell", inline: <<-SHELL
    echo vagrant:vagrant | chpasswd
      SHELL
end
