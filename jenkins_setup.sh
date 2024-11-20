#!/bin/bash

wget -O /usr/share/keyrings/jenkins-keyring.asc \
    https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key

echo "deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc]" \
    https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
    /etc/apt/sources.list.d/jenkins.list > /dev/null

echo "[+] updating packages..."
apt-get update -y
echo "[+]installing dependancies..."
apt-get install fontconfig unzip openjdk-17-jre -y
echo "[+]installing jenkins..."
apt-get install jenkins -y
echo "[*]installation successful!"
echo "[+]installing aws-cli"
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
./aws/install
echo "[+]setting up aws config"
export AWS_ACCESS_KEY_ID=<key_id>
export AWS_SECRET_ACCESS_KEY=<access_key>
export AWS_DEFAULT_REGION=ap-south-1
echo "[+]installing kubectl and eks"
curl -O https://s3.us-west-2.amazonaws.com/amazon-eks/1.31.2/2024-11-15/bin/linux/amd64/kubectl
chmod +x ./kubectl
mkdir -p $HOME/bin && cp ./kubectl $HOME/bin/kubectl && export PATH=$HOME/bin:$PATH
echo 'export PATH=$HOME/bin:$PATH' >> ~/.bashrc
# CHANGE NAME OF CLUSTER
aws eks update-kubeconfig --region ap-south-1 --name my-cluster
aws sts get-caller-identity
echo "[*]Jenkins Admin password:"
cat /var/lib/jenkins/secrets/initialAdminPassword
