# Monitoring Automation

## Overview

This section describes the monitoring automation implementation using Ansible and reusable Zabbix-agent roles.

The monitoring automation is intended to:
- configure monitored Linux hosts automatically
- support reproducible deployments
- simplify onboarding of monitored systems
- reduce manual configuration changes

---

## Ansible Monitoring Structure

```text
ansible/
├── inventory/
│ ├── production/
│ │ ├── hosts.yml
│ │ └── group_vars/
├── playbooks/
│ └── monitored_hosts.yml
├── roles/
│ └── zabbix-agent/
```

## Monitored Hosts

The monitored hosts inventory currently includes:

- zNode1 (Ubuntu)
- zNode2 (Ubuntu)
- zNode3 (Debian)
- zNode4 (Fedora)

Example inventory structure:

```yaml
monitored_linux:
  hosts:
    zNode1:
      ansible_host: 10.8.50.67
      ansible_user: ubuntu
```

## Zabbix-Agent Role

The zabbix-agent role currently performs:

- installation of zabbix-agent package
- deployment of configuration template
- service enable/start
- reusable variable-based configuration

Role structure:

```text
roles/zabbix-agent/
├── defaults/
├── handlers/
├── tasks/
└── templates/
```

## Configuration Template

The configuration template uses Ansible variables:

```jinja2
Server={{ zabbix_server }}
ServerActive={{ zabbix_server }}
Hostname={{ inventory_hostname }}
```

## Validation / Test Cases

### Inventory Validation

```bash
ansible-playbook playbooks/monitored_hosts.yml --list-hosts
```

Expected hosts:

- zNode1
- zNode2
- zNode3
- zNode4

### Syntax Validation

```bash
ansible-playbook playbooks/monitored_hosts.yml --syntax-check
```

Expected result:

```text
playbook: playbooks/monitored_hosts.yml
```

## Current Status

- Monitoring inventory implemented
- Zabbix-agent role implemented
- Playbook syntax validation successful
- Awaiting SSH/public-key authorization for zNode1–4
