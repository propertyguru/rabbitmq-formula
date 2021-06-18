#!/bin/bash
## Create shovel users-forward-converter-delta

rabbitmqctl -p users-api set_parameter shovel users-forward-converter-delta  '{"src-protocol": "amqp091", "src-uri": "amqp://usersapi@/users-api", "src-exchange": "users-api", "src-exchange-key": "user.update.delta", "dest-protocol": "amqp091", "dest-uri": "amqp://data-bridge@/data-bridge", "dest-exchange": "forward-converter", "ack-mode": "on-confirm","src-delete-after": "never"}' {%- if dry_run == "False" %}--dry-run{%- endif %}
