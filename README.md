
# PrimaStack 


## Description
This projects sets up OpenStack VMs and what they need in order to work, as well as Zabbix


## Deploy OpenStack VMs & setup Zabbix 7.0

### INSTRUCTIONS  
What is needed to setup VMs and Zabbix
- Ansible (core 2.16.3) 
- Python (3.12)
- Openstack Project

The instructions below will Install the Network/Subnet/KeyPair/SecurityGroup/Floating IP/Instances needed for the Zabbix Servers (2x Zabbix server nodes, 1x Zabbix DBm and 1x Ansible Center).

#### 1. Download the openrc.sh from OpenStack, and put it in the "Deploy" folder. 

#### 2. Activate the OpenStack environment from the Deploy folder by the terminal

Command: source openrc.sh
- Log in with the projects credentials (Password)
   
#### 3. From Deploy folder - Install OpenStack resources

***COMMAND:***        ansible-playbook -i ansible/inventory.ini ansible/playbooks/install.yml
 
#### 4. From Deploy folder - Setup Zabbix on OpenStack resources

***COMMAND:***         ansible-playbook -i ansible/inventory.ini ansible/playbooks/configure.yml
 
#### 5 TEST:

##### 1. On local machine (Make sure .ssh/config is set, so you can access the tunnel)

Make sure (/.ssh/config) is set, so you can access the tunnel. This is done by copying the content from (Deploy/ansible/ssh_config_copy) to machines SSH config (/.ssh/config). From this file, you can get the IP for zabbix-one and ssh into the machine as key exists from installation (Key -> /.ssh/ansible).

***COMMAND:***       ssh -L 8080:<IP_TO_ZABBIX_ONE>:80 ubuntu@ansible-center

##### 2. Access localhost:8080 on the local machine
There is an SSH tunnel from step 1 of the test and zabbix can be accessed like: 

localhost:8080
login (Admin;zabbix) 

Then through "Reports" → "System Information", the following should be seen:

- High availability cluster : Should be enabled
- zabbix-two and zabbix-two should be listed, and which one is active will be shown

##### 3. Failover Test
SSS into zabbix-one, and activate:

***COMMAND:***         ssh zabbix-one
***COMMAND:***        systemctl stop zabbix-server

You should see (like in step 2), through "Reports" → "System Information", that the zabbix nodes changed which Server is active. 

## Monitoring Nodes

### Chapter to be written......

