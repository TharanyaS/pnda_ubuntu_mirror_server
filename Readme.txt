# PNDA mirror server - ubuntu
Non-deepinsight users:
1. Install git
	Ubuntu: apt-get install -y git
	RHEL: yum install -y git
2. Install wget
        Ubuntu: apt-get install -y wget
        RHEl: yum install -y wget
3. git clone https://github.com/TharanyaS/pnda_ubuntu_mirror_server.git
4. cd pnda_ubuntu_mirror_server
5. Run install_packages.sh to install necessary packages 
6. Copy the private_key_file to pnda_ubuntu_mirror_server/keys/ directory
7. Run "terraform apply" command
8. Provide the values for access_key, secret_key, region and ssh_key_name - Ex: private_key
Example:
var.access_key
  Enter a value: xxx

var.region
  Enter a value: us-east-1

var.secret_key
  Enter a value: xxxx

var.ssh_key_name
  Enter a value: private_key

Deepinsight Users:
1. Install git 
	Ubuntu: apt-get install -y git
	RHEL: yum install -y git
2. Install wget
        Ubuntu: apt-get install -y wget
        RHEl: yum install -y wget
3. git clone https://github.com/TharanyaS/pnda_ubuntu_mirror_server.git
4. cd pnda_ubuntu_mirror_server
5. Copy the private_key_file to pnda_ubuntu_mirror_server/keys/ directory
6. Run "terraform init" command
7. Run "terraform apply" command
8. Provide the values for access_key, secret_key, region and ssh_key_name - Ex: private_key
Example:
var.access_key
  Enter a value: xxx

var.region
  Enter a value: us-east-1

var.secret_key
  Enter a value: xxxx

var.ssh_key_name
  Enter a value: private_key

