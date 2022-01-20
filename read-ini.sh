#!/bin/bash
#This script will extract vaules from a ini config file. 
# arg1 is config.ini file
# arg2 is the section (defines with [])
# arg3 is the key within the section

function parse_ini() {
    cat /dev/stdin | awk -v section="$1" -v key="$2" '
    BEGIN {
    if (length(key) > 0) { params=2 }
    else if (length(section) > 0) { params=1 }
    else { params=0 }
    }
    match($0,/;/) { next }
    match($0,/#/) { next }
    match($0,/^\[(.+)\]$/){
    current=substr($0, RSTART+1, RLENGTH-2)
    found=current==section
    if (params==0) { print current }
    }
    match($0,/(.+)=(.+)/) {
    if (found) {
        if (params==2 && key==substr($1, 0, length(key))) { print substr($0, length(key)+2) }
        if (params==1) { printf "%s\n",$1,$3 }
    }
    }'
}

if [[ -z $3 ]]
then
        echo "ERROR: Required parameters not passed"
	echo "Syntax: read-ini [arg1] [arg2] [arg3]"
	echo "Arguments:"
	echo -e '\t arg1 = config.ini file'
	echo -e '\t arg2 = section (defined in ini file with [])'
	echo -e '\t arg3 = variable key (within the section)'
	exit 1

else
	parse_ini $2 $3 < $1 | awk '{
				    if ($1=="="){
				    print $2
				    } 
				    else{
				    print $1
				    }
			       }'
fi
