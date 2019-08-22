#!/usr/bin/env sh

if [ ! -n "$(which sed)" ]; then echo "sed not installed/does not appear in $PATH"; exit 1; fi
if [ ! -n "$(which curl)" ]; then echo "curl not installed/does not appear in $PATH"; exit 1; fi
if [ ! -n "$(which jq)" ]; then echo "jq not installed/does not appear in $PATH"; exit 1; fi

curl -s http://localhost/admin/api.php | jq '.' |
        sed 's|"enabled"|1|g' | # changes enabled to 1 and removes quote ["status": "enabled" -> "status": 1]
        sed 's|"disabled"|0|g' |  # changes disabled to zero and removes quote ["status": "disabled" -> "status": 0]
        sed 's|status|enabled|g' | # changes status to enabled to better fit boolean value ["status": "enabled" -> "enabled": 1]
        sed 's|true|1|g' | # changes true to 1 [ "file_exists": true -> "file_exists": 1]
        sed 's|false|0|g' | # changes false to 0 [ "file_exists": false -> "file_exists": 0]
        sed 's|"\([[:digit:]]\+\)"|\1|g' | # removes the quotes around any digits ["hours": "03" -> "hours": 03]
        sed -r 's/0+([0-9]+)/\1/g'; # removes any leading zeros but only if there's a digit after it ["hours": 03 -> "hours": 3]

