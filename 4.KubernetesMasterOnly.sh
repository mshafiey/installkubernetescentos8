
echo "Configure kubeadm."
kubeadm config images pull
echo "\n---------------------------------------------------------------done"


echo "Open the necessary ports used by Kubernetes."
firewall-cmd --zone=public --permanent --add-port={6443,2379,2380,10250,10251,10252}/tcp
echo "\n---------------------------------------------------------------done"

echo "Allow docker access from another node, replace the worker-IP-address with yours."
firewall-cmd --zone=public --permanent --add-rich-rule 'rule family=ipv4 source address=127.0.0.2/32 accept'
echo "\n---------------------------------------------------------------done"


echo "Allow access to the hosts localhost from the docker container."
firewall-cmd --zone=public --permanent --add-rich-rule 'rule family=ipv4 source address=127.0.0.1 accept'
echo "\n---------------------------------------------------------------done"


echo " Make the changes permanent."
firewall-cmd --reload
echo "\n---------------------------------------------------------------done"


echo " Install CNI (container network interface) plugin for Kubernetes."
kubeadm init --pod-network-cidr 127.0.0.0/16
echo "\n---------------------------------------------------------------done"


echo "calico.yaml"
mkdir -p $HOME/.kube
cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
chown $(id -u):$(id -g) $HOME/.kube/config
kubectl apply -f https://docs.projectcalico.org/manifests/calico.yaml
echo "\n---------------------------------------------------------------done"

