#!/bin/bash

echo 'Please, inform BIG-IP managemnt IP, username and password to connect to the BIG-IP'
read -p 'BIG-IP mgmt IP: ' host
read -p 'Username: ' user
read -sp 'Password: ' pass
echo ''
 
# Search Virtual properties for pool name references.  Put all pool names in variable a.
a=$(curl -sku $user:$pass https://$host/mgmt/tm/ltm/virtual | sed 's/,/\n/g' | grep '"pool":' | awk -F\" '{print $4}' );
# Search Pool definitions for all pool names.  Put list of pool names in variable b.
b=$(curl -sku $user:$pass https://$host/mgmt/tm/ltm/pool | sed 's/,/\n/g' | grep '"fullPath":' | awk -F\" '{print $4}') ;
# For each pool name from general list b, scan for that in list a.  If not found, then decalare Orphaned.
for x in $b; do echo $a | grep ${x} >/dev/null && echo null >/dev/null || echo " ${x} Orphaned"  ; done
