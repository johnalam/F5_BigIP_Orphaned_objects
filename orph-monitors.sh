#!/bin/bash
echo 'Please, inform BIG-IP managemnt IP, username and password to connect to the BIG-IP'
read -p 'BIG-IP mgmt IP: ' host
read -p 'Username: ' user
read -sp 'Password: ' pass
echo ''

monitor_types="http https http2 tcp udp ftp icmp gateway_icmp"
system_monitor_names="/Common/http== /Common/https== /Common/http2== /Common/http_head_f5== /Common/http2_head_f5== /Common/https_443== /Common/https_head_f5== /Common/icmp== /Common/gateway_icmp== /Common/tcp== /Common/udp== /Common/ftp=="

# Search pool properties for monitor name references.  Put all monitor names in variable a.

a=$(curl -sku $user:$pass https://$host/mgmt/tm/ltm/pool | sed 's/,/\n/g' | grep '"monitor":')
if [ -z "$a" ]
then
        echo
        echo "Check connection and/or credentials"
        echo
        exit
fi



for typ in $monitor_types
do
    echo
    echo "Searching for orphans of monitor type $typ"
    # Search monitor definitions for all monitor names.  Put list of monitor names in variable b.
    b=$(curl -sku $user:$pass https://$host/mgmt/tm/ltm/monitor/$typ | sed 's/,/\n/g' | grep '"fullPath":' | awk -F\" '{print $4}') ;
    # For each monitor name from general list b, scan for that in list a.  If not found, then decalare Orphaned.
    for x in $b
    do
        c=$(echo $system_monitor_names | grep "${x}==")
        if [ -z "$c" ]
        then
                d=$(echo $a | grep '${x}\"')
                if [ -z "$d" ]
                then 
                    echo " ${x} Orphaned"
                fi
        fi
    done

done

