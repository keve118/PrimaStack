############ INSTRUCTIONS  ############
To use this repository, and its functions, one need 
- Ansible (core 2.16.3) 
- Python (3.12)
- Openstack Project

The instructions below will Install the Network/Subnet/KeyPair/SecurityGroup/Floating IP/Instances
needed for the Zabbix Servers (2x Zabbix server nodes, 1x Zabbix DBm and 1x Ansible Center).

DO NOTE that this will overwrite your .ssh/config, with credentials needed for using SSH 
for accessing the servers. The ansible script will install SSH keys as well. 

1. Download the openrc.sh from openstack, and put it in the "Deploy folder" 
2. Activate the OpenStack environment from the Deploy folder by the terminal

Command: source openrc.sh
- Log in with the projects credentials (Password)
   
3. Activate the ansible script from deploy folder:

 Commnand: ansible-playbook -i inventory ansible/playbooks/test.yml
