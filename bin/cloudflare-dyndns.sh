#!/usr/bin/env bash

# Required env vars
# CLOUDFLARE_ZONE="xxx"
# CLOUDFLARE_DNS_RECORD_ID="xxx"
# CLOUDFLARE_EMAIL="xxx"
# CLOUDFLARE_KEY="xxx"

# Update Cloudflare DNS record with current detected public IP
# https://api.cloudflare.com/#dns-records-for-a-zone-patch-dns-record
 function updateIp {
   IPADDR=$(curl -s checkip.amazonaws.com)
   echo $IPADDR

   curl -X PATCH "https://api.cloudflare.com/client/v4/zones/$CLOUDFLARE_ZONE/dns_records/$CLOUDFLARE_DNS_RECORD_ID" \
     -H "X-Auth-Email: $CLOUDFLARE_EMAIL" \
     -H "X-Auth-Key: $CLOUDFLARE_KEY" \
     -H "Content-Type: application/json" \
    --data "{\"content\":\"$IPADDR\"}"
 }

 updateIp