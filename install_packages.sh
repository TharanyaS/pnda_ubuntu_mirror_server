if [ -f /etc/redhat-release ]; then
    yum install -y zip unzip
fi
if [ -d /etc/apt/ ]; then
    apt-get install -y zip unzip
fi
wget https://releases.hashicorp.com/terraform/0.10.8/terraform_0.10.8_linux_amd64.zip
unzip terraform_0.10.8_linux_amd64.zip
mv terraform /usr/local/bin/
terraform init

