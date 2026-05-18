# PrimaStack 

## Description
This projects sets up OpenStack VMs and what they need in order to work, as well as Zabbix.

## Deploy OpenStack VMs & setup Zabbix 7.0

### INSTRUCTIONS  
What is needed to setup VMs and Zabbix
- Ansible (core 2.16.3) 
- Python (3.12)
- Openstack Project (with credentials)

Resources on OpenStack that needs to be available:
4 VM instances, 4 vCPUs
2GB x 4 VM  = 8GB RAM

The amount of instances and its resources, is due to this installation enabling a "High Availability" Zabbix cluster. If zabbix-one goes down, it is automatically configured so that zabbix-two takes over. 

NOTE: Certain OpenStack settings might be buggy, and therefore need 16GB RAM, and 8 vCPUS and 8 instances. Also make sure you have no instances called either 'zabbix-one', 'zabbix-two', 'zabbix-db' or 'ansible-center', as these will be removed and converted for this to install. If VMs are installed and inventory.ini is created and filled from the first ansible step, but zabbix needs to be reconfigured, follow the manual installation steps but from  "Setup Zabbix on OpenStack resources" which will reconfigure the project. 

The instructions below will Install the Network/Subnet/KeyPair/SecurityGroup/Floating IP/Instances needed for the Zabbix Servers (2x Zabbix server nodes, 1x Zabbix DB and 1x Ansible Center).

### Fast INSTALL (BASH) 

#### 1. Download the openrc.sh from OpenStack, and put it in the "Deploy" folder. 

#### 2. Give permission and install

This does essentially the same as the manual installation guide below, but without doing everything manually.

***COMMAND:***  chmod +x install.sh

***COMMAND:*** ./install.sh

#### 3. Test! 

See section "TEST ZABBIX"

### Manual INSTALL 

#### 1. Download the openrc.sh from OpenStack, and put it in the main repository folder. 

#### 2. Activate the OpenStack environment from the Deploy folder by the terminal

***COMMAND:***  source openrc.sh

- Log in with the projects credentials (Password)
   
#### 3.  Install OpenStack resources

From Deploy folder:

***COMMAND:*** ansible-playbook -i Deploy/ansible/inventory.ini Deploy/ansible/playbooks/install.yml

 
#### 4. Setup Zabbix on OpenStack resources

From Deploy folder:

***COMMAND:*** ansible-playbook -i Deploy/ansible/inventory.ini Deploy/ansible/playbooks/configure.yml
 
### TEST ZABBIX:

#### 1. On local machine (Make sure .ssh/config is set, so you can access the tunnel)

Make sure (/.ssh/config) is set, so you can access the tunnel. This is done by copying the content from (Deploy/ansible/ssh_config_copy) to machines SSH config (/.ssh/config). From this file, you can get the IP for zabbix-one and ssh into the machine as key exists from installation (Key -> /.ssh/ansible).

***COMMAND:***       ssh -L 8080:<IP_TO_ZABBIX_ONE>:80 ubuntu@ansible-center

#### 2. Access Zabbix on the local machine
There is an SSH tunnel from step 1 of the test and zabbix can be accessed like: 

- localhost:8080

- login (Admin;zabbix) 

Then through "Reports" → "System Information", the following should be seen:

- High availability cluster : Should be enabled
- zabbix-two and zabbix-two should be listed, and which one is active will be shown

#### 3. Failover Test
SSS into zabbix-one, and activate:

***COMMAND:***        ssh zabbix-one

***COMMAND:***        sudo systemctl stop zabbix-server

You should see (like in step 2), through "Reports" → "System Information", that the zabbix nodes changed which Server is active. 

## Monitoring Nodes

### Chapter to be written......

