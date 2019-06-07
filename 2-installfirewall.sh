#!/bin/sh

esxcli network firewall unload 

cp ssh2.xml /etc/vmware/firewall

esxcli network firewall load
esxcli network firewall refresh
esxcli network firewall ruleset list |grep -i ssh
