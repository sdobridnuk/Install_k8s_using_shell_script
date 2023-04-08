# Install_k8s_using_shell_script

Installation of Kubernetes through Kubeadm-way for Master-Node and Worker-Node from single shell script ( k8s_installtion.sh) for any patch version of 1.26 

Kubernetes version - 1.26
CRI - containerd + Docker
CNI - Weave Net

Pre-Requisite :

1.  ubuntu 22.10 / 22.04 / 20.04 / 18.04
2.  2vCPU and 4 GB Ram
3.  Required Port for k8s components should be open in firewall/security_groups


Info on Running script :

1. There can be couple of prompt
2. There will be Main one propt of Making it master-node or not [ At this stage, this node ready as worker node by Enter:1 and then manually adding kubeadm join token command BUT to make it master-node Enter: 0]
3. if master-node in notReady then try to catch error
   1. systemctl deamon-reload && systemctl restart kubelet && kubectl get nodes
   2. kubectl describe node your_control_plane_node_name

Feedback Please:
if you applied this shell script, Please share your feedback on  - 

References:
1. https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/install-kubeadm/
2. https://kubernetes.io/docs/setup/production-environment/container-runtimes/
3. https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/create-cluster-kubeadm/
4. https://www.weave.works/docs/net/latest/kubernetes/kube-addon/
5. https://docs.docker.com/engine/install/ubuntu/
