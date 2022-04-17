
echo "Add the Kubernetes repository to your package manager by creating the following file."
cat < /etc/yum.repos.d/kubernetes.repo
[kubernetes]
name=Kubernetes
baseurl=https://packages.cloud.google.com/yum/repos/kubernetes-el7-$basearch
enabled=1
gpgcheck=1
repo_gpgcheck=1
gpgkey=https://packages.cloud.google.com/yum/doc/yum-key.gpg https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg
exclude=kubelet kubeadm kubectl
EOF
echo "\n---------------------------------------------------------------done"



echo "Then update the repo info."
dnf upgrade -y
echo "\n---------------------------------------------------------------done"


echo "Install all the necessary components for Kubernetes."
dnf install -y kubelet kubeadm kubectl --disableexcludes=kubernetes
echo "\n---------------------------------------------------------------done"


echo "Start the Kubernetes services and enable them to run at startup."
systemctl enable kubelet
systemctl start kubelet
echo "\n---------------------------------------------------------------done"
