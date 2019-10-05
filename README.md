# macOS-ansible

[![Build Status](https://img.shields.io/circleci/project/github/gperdomor/macOS-ansible.svg?label=Build)](https://circleci.com/gh/gperdomor/macOS-ansible)

This playbook installs and configures most of the software I use on my Mac for web and software development. Some things in macOS are slightly difficult to automate, so I still have some manual installation steps, but at least it's all documented here.

This is a work in progress, and is mostly a means for me to document my current Mac's setup. I'll be evolving this set of playbooks over time.

### Goal

Automate system setup from a clean install of macOS 10.13+

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

- macOS 10.14, 10.15 ([help](https://support.apple.com/en-us/HT201372)).
- Signin to the App Store
- Command Line Developer Tools ([help](docs/install_command_line_developer_tools.md)).
- Ansible >= 2.4 ([help](docs/install_ansible.md)).

## Installation

1. Ensure Apple's command line tools are installed (`xcode-select --install` to launch the installer).
2. Run `bash scripts/install_deps.sh`
3. Clone this repository to your local drive.
4. Run `ansible-galaxy install -r custom/requirements.yml --force` inside this directory to install required Ansible roles.
5. Run `ansible-playbook main.yml -K` inside this directory. Enter your account password when prompted.

> Note: If some Homebrew commands fail, you might need to agree to Xcode's license or fix some other Brew issue. Run `brew doctor` to see if this is the case.

## Usage

### Download externally sourced roles

Remotely sourced Ansible roles can be specified in `custom/requirements.yml`. Before running the playbook you'll need to download any Ansible roles specified here by running the following command:

```sh
ansible-galaxy install -r custom/requirements.yml --force
```

Roles downloaded in this way will be placed in `custom/roles/external`. If you wish to create any roles within this repository you can do so in `custom/roles/internal`.

### Configure

Default variables can be overridden in `custom/config.yml`.

`custom/config.local.yml` can be used to override `custom/config.yml` which can be useful when you need to use different values for just a few variables on a specific system. By default `custom/config.local.yml` is ignored by git.

### Run the Ansible playbook

The primary Ansible playbook file is `playbook.yml` and can be run using the following command (asks for sudo password):

```sh
ansible-playbook playbook.yml -K
```

To run only certain tags (e.g. `firefox` and `mac__dev`):

```sh
ansible-playbook playbook.yml -K -t "firefox,mac__dev"
```
