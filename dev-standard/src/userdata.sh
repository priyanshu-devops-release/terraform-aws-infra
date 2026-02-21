#!/bin/bash
set -e
exec > /var/log/user-data.log 2>&1

echo "=== Starting Jenkins Setup ==="

# Update system
yum update -y

# Install Java 25
echo "=== Installing Java 25 ==="
yum install -y java-25-amazon-corretto
java -version

# Create tomcat user
useradd -m -U -d /opt/tomcat -s /bin/false tomcat

# Install Tomcat 11
echo "=== Installing Tomcat 11 ==="
cd /opt
wget https://dlcdn.apache.org/tomcat/tomcat-11/v11.0.4/bin/apache-tomcat-11.0.4.tar.gz
tar -xvf apache-tomcat-11.0.4.tar.gz
mv apache-tomcat-11.0.4 /opt/tomcat
chown -R tomcat:tomcat /opt/tomcat
chmod +x /opt/tomcat/bin/*.sh

# Download Jenkins WAR
echo "=== Downloading Jenkins ==="
wget https://get.jenkins.io/war-stable/latest/jenkins.war -O /opt/tomcat/webapps/jenkins.war
chown tomcat:tomcat /opt/tomcat/webapps/jenkins.war

# Create Tomcat systemd service
echo "=== Creating Tomcat Service ==="
cat <<EOF > /etc/systemd/system/tomcat.service
[Unit]
Description=Tomcat 11 Service
After=network.target

[Service]
Type=forking
User=tomcat
Group=tomcat
Environment="JAVA_HOME=/usr/lib/jvm/java-25-amazon-corretto"
Environment="CATALINA_HOME=/opt/tomcat"
ExecStart=/opt/tomcat/bin/startup.sh
ExecStop=/opt/tomcat/bin/shutdown.sh
Restart=on-failure

[Install]
WantedBy=multi-user.target
EOF

# Enable and start Tomcat
systemctl daemon-reload
systemctl enable tomcat
systemctl start tomcat

echo "=== Jenkins Setup Complete ==="
echo "Access Jenkins at http://<public-ip>:8080/jenkins"
