#!/bin/bash

sudo apt -y install nano
sudo apt update
sudo apt -y upgrade
sudo apt -y install apt-transport-https ca-certificates curl gnupg2 software-properties-common

# Disable swap 
sudo swapoff -a

# ----------   Configure prerequisites  ( kubernetes.io/docs/setup/production-environment/container-runtimes/ )
sudo cat <<EOF | sudo tee /etc/modules-load.d/k8s.conf
overlay
br_netfilter
EOF

sudo modprobe overlay
sudo modprobe br_netfilter

sudo cat <<EOF | sudo tee /etc/sysctl.d/k8s.conf
net.bridge.bridge-nf-call-iptables  = 1
net.bridge.bridge-nf-call-ip6tables = 1
net.ipv4.ip_forward                 = 1
EOF

# Apply sysctl params without reboot
sudo sysctl --system
 
lsmod | grep br_netfilter
lsmod | grep overlay

# Verify that is all outcomes are 1
#sysctl net.bridge.bridge-nf-call-iptables net.bridge.bridge-nf-call-ip6tables net.ipv4.ip_forward

#Install CRI-O
export OS=xUbuntu_22.04
export CRIO_VERSION=1.25

echo "deb https://download.opensuse.org/repositories/devel:/kubic:/libcontainers:/stable/$OS/ /"| tee /etc/apt/sources.list.d/devel:kubic:libcontainers:stable.list
echo "deb http://download.opensuse.org/repositories/devel:/kubic:/libcontainers:/stable:/cri-o:/$CRIO_VERSION/$OS/ /"| tee /etc/apt/sources.list.d/devel:kubic:libcontainers:stable:cri-o:$CRIO_VERSION.list
curl -L https://download.opensuse.org/repositories/devel:kubic:libcontainers:stable:cri-o:$CRIO_VERSION/$OS/Release.key | apt-key add -
curl -L https://download.opensuse.org/repositories/devel:kubic:libcontainers:stable:cri-o:$CRIO_VERSION/$OS/Release.key | apt-key add -
curl -L https://download.opensuse.org/repositories/devel:/kubic:/libcontainers:/stable/$OS/Release.key | apt-key add -
apt update && apt -y install cri-o cri-o-runc cri-tools

systemctl start crio && systemctl enable crio
systemctl status -lines=20 crio

#Install k8s
curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.29/deb/Release.key | gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg
echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.29/deb/ /' | tee /etc/apt/sources.list.d/kubernetes.list
apt update && apt -y install kubelet kubeadm kubectl && apt-mark hold kubelet kubeadm kubectl

#MASTER  
#kubeadm init --pod-network-cidr=10.244.0.0/16
#mkdir -p $HOME/.kube
#sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
#sudo chown $(id -u):$(id -g) $HOME/.kube/config
#WORKER 
#kubectl get nodes
 
# ---------- Common configuration for both worker and master node is DONE
# ---------- Below one is For Master Node ( control-plane )
echo "\n At this stage your node is ready to work as worker node by adding join-token of cluster node"
read -p "To make it Control-plane ( master-node ) Enter 0 ,For Exit Enter 1  : " user_input
if [ "$user_input" -eq 0 ];then
        user_ip = hostname -I | awk '{print $1}'
	echo "Initializing Kubeadm , may take some time"
	# ------- good practice to pass cidr as it invert overlapping of k8s network with host network 
	if sudo kubeadm init --pod-network-cidr=10.244.0.0/16 --apiserver-advertise-address=$user_ip --ignore-preflight-errors=all | grep -q 'kubeadm join';then
		echo ""
		
	else 
		sudo kubeadm reset
		sudo systemctl daemon-reload
		sudo systemctl restart kubelet
		sudo systemctl status kubelet
		sudo kubeadm init --pod-network-cidr=10.244.0.0/16 --apiserver-advertise-address=$user_ip --ignore-preflight-errors=all -y
        fi
	sudo mkdir -p $HOME/.kube
	sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
	sudo chown $(id -u):$(id -g) $HOME/.kube/config
	echo "\n Control-Plane is Ready \n"
	sudo kubectl get nodes
	echo "\n copy below one token to pass it to Worker Nodes\n"
	sudo kubeadm token create --print-join-command
	echo "\n----- complete -----\n"
	sudo systemctl daemon-reload
	sudo systemctl daemon-reload
	sudo kubectl get nodes
	echo "please restart daemon-reload once again [ systemctl daemon-reload ] then [ kubectl get nodes ]"
else
	echo "\nTo make this NODE as control plane, Refer - kubernetes.io/docs/setup/production-environment/tools/kubeadm/create-cluster-kubeadm/\n"
	echo "\n----- complete -----\n"
	sudo systemctl daemon-reload
fi
