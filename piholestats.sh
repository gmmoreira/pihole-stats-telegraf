#!/usr/bin/env sh

curl http://localhost/admin/api.php | jq '.|{ domains_being_blocked, dns_queries_today, ads_blocked_today, ads_percentage_today }' 
