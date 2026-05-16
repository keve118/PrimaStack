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
## Monitoring Capabilities

## What Is Being Monitored

The monitored Linux hosts are intended to provide operational visibility through Zabbix agents.

The monitoring system is designed to monitor:

- CPU utilization
- Memory usage
- Disk usage
- Host availability
- Network reachability
- Zabbix-agent service availability

## Monitoring Workflow

1. The monitored hosts are defined in the Ansible inventory.
2. The `monitored_hosts.yml` playbook targets the `monitored_linux` group.
3. The `zabbix-agent` role installs and configures the Zabbix agent.
4. The configuration template automatically configures:
   - Zabbix server address
   - Active server address
   - Hostname
5. The Zabbix server can collect monitoring metrics from the hosts.

## Monitoring Validation

### SSH Reachability

```bash
ansible -i inventory/production/hosts.yml all -m ping
```

Purpose:
- verifies Ansible connectivity
- validates SSH access
- confirms inventory correctness

### Future Validation

After full deployment, validation can also be performed through:
- Zabbix Web UI
- host availability status
- agent availability status
- collected performance metrics

## Current Status

- Monitoring inventory implemented
- Zabbix-agent role implemented
- Playbook syntax validation successful
- Monitoring deployment structure validated and ready for integration
