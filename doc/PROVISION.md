# Provisioning

The scripts are tailored for Ubuntu 13.10 x64, but they should work with little modifications (if any) on later versions.

## Summary

1. Install Ansible on workstation.
2. Create server (i.e., DigitalOcean droplet) and don't forget to add your SSH key.
3. Customize `provision/vars.yml` if needed.
4. Provision: `$ rake staging|production provision:cold`.
5. Grab a cup of Bulletproof coffee and feel truly bulletproof.

## Detailed Steps

A bare bones Ubuntu server with SSH is all that is needed. Ansible is used for provisioning. [Installation instructions][1]. For Ubuntu:

    $ sudo add-apt-repository ppa:rquillo/ansible
    $ sudo apt-get update
    $ sudo apt-get install ansible

[1]:http://www.ansibleworks.com/docs/intro_installation.html#installing-the-control-machine

The `hosts.ini` file contains definitions for the server addresses. You can either setup aliases in your `/etc/hosts` file to point to real IPs, or modify the `hosts.ini` file directly.

Customize variables at `provision/vars.yml` if needed and provision the server:

    $ rake staging|production provision:setup
    $ rake staging|production provision
    $ rake staging|production provision:reboot

The first time, you can simply run the following command, which will execute all the previous three:

    $ rake staging|production provision:cold
