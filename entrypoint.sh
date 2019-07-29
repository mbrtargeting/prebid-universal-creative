#!/usr/bin/env bash

consul_agent_host='local-consul-agent'
service_check_host="${SERVICE_CHECK_HOST:-localhost}"

export PORT=9990

echo 'Registering with consul'

service_id="prebid-creative-${instance}"

curl -s http://${consul_agent_host}:8500/v1/agent/service/deregister/${service_id}
curl -s -H 'Content-Type: application/json' -X PUT -d '{
    "id": "'"${service_id}"'",
    "name": "prebid-creative",
    "port": '"${PORT}"',
    "checks": [
        {
            "name": "HTTP port '"${PORT}"'",
            "http": "http://'"${service_check_host}"':'"${PORT}"'/dist/load-cookie.html",
            "interval": "10s"
        }
    ]
}' http://${consul_agent_host}:8500/v1/agent/service/register

echo "Registered prebid-creative with consul"
exec yarn run serve
