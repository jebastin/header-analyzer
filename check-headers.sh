#!/bin/bash
if [ $# -eq 0 ]
  then
    echo "Provide the file with list of urls, ex. check-script.sh urls.txt"
    exit 128
fi

user_agent='Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_4) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/43.0.2357.130 Safari/537.36'

##
## Support for multiple user agents
## Firefox 
##

in_file=$1
outdir=out_$(date +"%Y_%b_%d_%M_%I_%S_%Z")

echo "******  creating output directory :  $outdir *********"
mkdir $outdir

while read line           
do
	echo "******************************************************"
	echo $line

	## Add check for empty line
	if [[ ${line:0:1} == '#' ]] 
	then 
	    continue 
	fi

	outfile=$outdir/$(echo $line | cut -d'/' -f3- | sed s@/@_@g).txt
	
	echo $outfile
	
	curl -s -I -A $user_agent -H 'Pragma:akamai-x-get-client-ip, akamai-x-cache-on, akamai-x-cache-remote-on, akamai-x-check-cacheable, akamai-x-get-cache-key, akamai-x-get-extracted-values, akamai-x-get-nonces, akamai-x-get-ssl-client-session-id, akamai-x-get-true-cache-key, akamai-x-serial-no, akamai-x-feo-trace, akamai-x-get-request-id' $line > $outfile
	
done < $in_file
