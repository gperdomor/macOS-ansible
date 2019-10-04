# Macsible

[![Build Status](https://travis-ci.org/macsible/macsible.svg?branch=master)](https://travis-ci.org/macsible/macsible)

### Requirements

Ensure the following requirements are already installed and working on your local system:

- macOS 10.13 ([help](https://support.apple.com/en-us/HT201372)).
- Command Line Developer Tools ([help](docs/install_command_line_developer_tools.md)).
- Ansible >= 2.4 ([help](docs/install_ansible.md)).

## Forking and customisation overview

1. Fork the repository at [https://github.com/macsible/macsible](https://github.com/macsible/macsible).
2. Clone the fork to your local system (this is now the repository you will use to store your own customisations).
3. Navigate to the local clone using your terminal app of choice.
4. Follow the usage instructions below.
5. Commit and push any customisations to your local clone back upstream to your fork.

You can see a working example of a forked and customised repository at [https://github.com/danbohea/macsible](https://github.com/danbohea/macsible).

## Usage

### Create required additional files

You'll need to create some additional required files before you begin your customisations. A script has been included to automate this:

```sh
bash scripts/copy_starter_files.sh
```

This will create the following files (copied from the `starter_files` directory):

```
.
├── ansible.cfg
└── custom
    ├── config.local.yml
    ├── config.yml
    ├── inventory.yml
    ├── mac.yml
    └── requirements.yml
```

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

The primary Ansible playbook file is `macsible.yml` and can be run using the following command (asks for sudo password):

```sh
ansible-playbook macsible.yml -K
```

To run only certain tags (e.g. `firefox` and `dev_apps`):

```sh
ansible-playbook macsible.yml -K -t "firefox,dev_apps"
```
