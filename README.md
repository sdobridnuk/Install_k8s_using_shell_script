# Install_k8s_using_shell_script

Some usefull BASH scripts

Note:
Installation of Kubernetes through Kubeadm-way for Master-Node and Worker-Node from single shell script ( k8s_installation.sh) for any patch version of 1.26 

Kubernetes version - 1.26
CRI - containerd + Docker
CNI - Weave Net

* Pre-Requisite :

1.  ubuntu 22.10 / 22.04 / 20.04 / 18.04
2.  2vCPU and 4 GB Ram
3.  Required Port for k8s components should be open in firewall/security_groups


* Info on Running script :

1. There can be couple of prompts
2. There will be main prompt of Making it master-node or not [ At this stage, this node ready as worker node by Enter:1 and then manually adding kubeadm join token command BUT to make it master-node Enter: 0]
3. if master-node is in notReady state then try to catch error with
   1. systemctl deamon-reload && systemctl restart kubelet && kubectl get nodes
   2. kubectl describe node your_control_plane_node_name

* If the weave-net pod is in a crash loop state then check logs, it might the weave-net IP range is overlapping with the host network . we allocated IPrange of  10.32.0.0/16 by changing the default of cidr /12. If 10.32.0.0/16 overlaps then first delete the weave-net daemonset and change the range in the env IPALLOC_RANGE of file weave-daemonset-k8s.yaml and then apply this yaml file.

* Feedback Please:
  if you applied this shell script, Please share your feedback on - https://www.linkedin.com/posts/digpal-parmar_cka-kubernetes-devops-activity-7050560850138476544-HgOh
  OR https://twitter.com/DigpalParmar2/status/1644804475205419010

* References:
1. https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/install-kubeadm/
2. https://kubernetes.io/docs/setup/production-environment/container-runtimes/
3. https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/create-cluster-kubeadm/
4. https://www.weave.works/docs/net/latest/kubernetes/kube-addon/
5. https://docs.docker.com/engine/install/ubuntu/
