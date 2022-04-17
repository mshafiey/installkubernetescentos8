echo "Add the repository for the docker installation package.\n"
dnf config-manager --add-repo=https://download.docker.com/linux/centos/docker-ce.repo
echo "\n---------------------------------------------------------------done"


echo " Install container.io which is not yet provided by the package manager before installing docker. "
dnf install https://download.docker.com/linux/centos/7/x86_64/stable/Packages/containerd.io-1.2.6-3.3.el7.x86_64.rpm
echo "\n---------------------------------------------------------------done"


echo " Then install Docker from the repositories. "
dnf install docker-ce --nobest -y
echo "\n---------------------------------------------------------------done"


echo " Start the docker service. "
systemctl start docker
echo "\n---------------------------------------------------------------done"


echo " Make it also start automatically on server restart. "
systemctl enable docker
echo "\n---------------------------------------------------------------done"


echo " Change docker to use systemd cgroup driver. "
echo '{
  "exec-opts": ["native.cgroupdriver=systemd"]
}' > /etc/docker/daemon.json
echo "\n---------------------------------------------------------------done"


echo " restart docker to apply the change."
systemctl restart docker
echo "\n---------------------------------------------------------------done"



echo " See the docker version."
docker version
echo "\n---------------------------------------------------------------done"

