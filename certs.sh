#!/bin/bash

DOMAINS=$(nginx -T | sed -r -e 's/[ \t]*$//' -e 's/^[ \t]*//' -e 's/^#.*$//' -e 's/[ \t]*#.*$//' -e '/^$/d' | \
sed -e ':a;N;$!ba;s/\([^;\{\}]\)\n/\1 /g' | \
grep -P 'server_name[ \t]' | grep -v '\$' | grep '\.' | \
sed -r -e 's/(\S)[ \t]+(\S)/\1\n\2/g' -e 's/[\t ]//g' -e 's/;//' -e 's/server_name//' | \
sort | uniq | xargs -L1)


for DOMAIN in $DOMAINS
do	
	if [ -d "/etc/letsencrypt/live/${DOMAIN}" ]
	then 
		
		echo "$DOMAIN already has a cert. Skipping"
	else
		if [ $DOMAIN != "lnxsystems.com" ]
		then
			certbot --nginx --renew-by-default   --redirect  -m jnvilo@gmail.com --agree-tos --eff-email -d $DOMAIN 
		fi
	fi 
done

