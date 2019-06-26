#!/bin/bash

curl -XPUT -H "Content-Type: application/json" 'http://elk:9200/_template/filebeat?pretty' -d@/etc/filebeat/filebeat.template.json
/etc/init.d/filebeat start