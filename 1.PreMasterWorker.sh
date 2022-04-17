echo "ervers are up to date before installing "
dnf -y upgrade
echo "\n---------------------------------------------------------------done"

echo "Disable SELinux enforcement."
setenforce 0
sed -i --follow-symlinks 's/SELINUX=enforcing/SELINUX=disabled/g' /etc/sysconfig/selinux
echo "\n---------------------------------------------------------------done"

echo "Enable transparent masquerading and facilitate Virtual Extensible LAN (VxLAN) "
modprobe br_netfilter
echo "---------------------------------------------------------------done"

echo "You will also need to enable IP masquerade at the firewall."
firewall-cmd --add-masquerade --permanent
firewall-cmd --reload
echo "\n---------------------------------------------------------------done"


echo "Set bridged packets to traverse iptables rules."
echo "
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
" >> /etc/sysctl.d/k8s.conf
echo "\n---------------------------------------------------------------done"


echo "Then load the new rules."
sysctl --system
echo "\n---------------------------------------------------------------done"


echo "Disable all memory swaps to increase performance."
swapoff -a
echo "\n---------------------------------------------------------------done"




