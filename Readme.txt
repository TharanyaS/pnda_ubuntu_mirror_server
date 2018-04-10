# PNDA mirror server - ubuntu
Non-deepinsight users:
1. Install git
	Ubuntu: apt-get install -y git
	RHEL: yum install -y git
2. git clone https://github.com/TharanyaS/pnda_ubuntu_mirror_server.git
3. cd pnda_ubuntu_mirror_server
4. Run install_packages.sh to install necessary packages 
5. Copy the private_key_file to pnda_ubuntu_mirror_server/keys/ directory
6. Run "terraform apply" command
7. Provide the values for access_key, secret_key, region and ssh_key_name - Ex: private_key

Deepinsight Users:
1. Install git 
	Ubuntu: apt-get install -y git
	RHEL: yum install -y git
2. git clone https://github.com/TharanyaS/pnda_ubuntu_mirror_server.git
3. cd pnda_ubuntu_mirror_server
4. Copy the private_key_file to pnda_ubuntu_mirror_server/keys/ directory
5. Run "terraform init" command
6. Run "terraform apply" command
7. Provide the values for access_key, secret_key, region and ssh_key_name - Ex: private_key

