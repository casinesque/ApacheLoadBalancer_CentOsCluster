echo "Starting script --------------------------------------------------------------"
#This will be executed from inside the machine so the path are those of the guest machine.
yum check update -y
yum update -y
#install httpd
sudo yum install httpd -y
#check httpd status
sudo systemctl start httpd
#check
sudo su
chkconfig httpd on
systemctl status httpd | grep -i active
#pwd 
#cat /vagrant/proxy.conf
machine_hostname=$(hostname) #Checking if the machine is the master
if [ "$machine_hostname" = "master-node" ]; then
    yes | rm /etc/httpd/conf.d/proxy.conf #remove current proxy conf configuration
    cp /vagrant/proxy.conf /etc/httpd/conf.d/
    echo "Proxy config has been copied" #The proxy conf must be set only on the master node.
fi    
cp /vagrant/index.html /var/www/html
sudo systemctl restart httpd.service #restart the httpd to take effects --> https://www.centlinux.com/2019/01/configure-apache-http-load-balancer-centos-7.html#point2
echo "Script executed, done-------------------------------------------------------"

