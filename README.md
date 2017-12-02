# macOS-ansible

[![Build Status](https://img.shields.io/circleci/project/github/gperdomor/macOS-ansible.svg?label=Build)](https://circleci.com/gh/gperdomor/macOS-ansible)

### Goal
Automate system setup from a clean install of macOS 10.13

...as much as we can.

### Why?
Why not?... Also...
- macOS updates are bad xD
- Manual setup from a clean install takes too long
- I run more than one system
- Automization is good!
- Help normalise systems between developers

### Requirements

Ensure the following requirements are already installed and working on your local system:

- macOS 10.12, 10.13
- Signin to the App Store
- Command Line Developer Tools or Xcode

## Usage

### Install dependencies

A script is included to ensure certain dependencies are met:

- Install pip and pexpect (if not already installed)
- Install Ansible (if not already installed)
- Download required Ansible Galaxy roles

To execute this script run:

```
bash init.sh
```

### Configure

Default variables can be overridden in config.yml

### Updating externally sourced roles

If you decide to add/edit the roles listed in requirements.yml (highly encouraged!) then you'll need to make sure that those dependencies are in place before running your playbook. After editing requirements.yml you'll want to run the following command before running your playbook:

```
ansible-galaxy install -r requirements.yml --force
```

### Run the Ansible playbook

The primary Ansible playbook file is called mac.yml and can be run using the following command (asks for sudo password):

```
ansible-playbook main.yml -K
```

To run only certain tags (e.g. `xcode` and `opera`):

```
ansible-playbook main.yml -K -t "xcode,opera"
```
