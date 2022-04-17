
echo " Open ports used by Kubernetes."
firewall-cmd --zone=public --permanent --add-port={10250,30000-32767}/tcp
echo "\n---------------------------------------------------------------done"


echo "Make the changes permanent."
firewall-cmd --reload
echo "\n---------------------------------------------------------------done"

