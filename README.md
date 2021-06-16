# Quickstart

```
$ ./bootstrap.sh
```

# Enable the plugin

```
vagrant plugin install vagrant-disksize
```
# Start the Virtual Machine 

```
$ vagrant up
$ vagrant ssh
```

## Start Minikube
From inside the VM:

```
$ minikube start --network-plugin=cni

```

## kubectl
From inside the VM:

```
source /vagrant/provision/minikube/activate

```

## Deploy Cilium
From inside the VM:

```
$ cd /vagrant/provision/minikube
$ ./deploy-cilium.sh
```

## Deploy Cilium-CLI
From inside the VM:

```
$ cd /vagrant/provision/minikube
$ ./deploy-cilium-cli.sh
```


## Deploy Monitoring
The following deploys an instance of Prometheus and Grafana
to monitor the Cilium and Hubble services

```
$ cd /vagrant/provision/minikube
$ ./deploy-monitoring.sh
```




