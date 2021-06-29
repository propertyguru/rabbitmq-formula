create_dynamic_shovel:
  cmd.script:
    - source: salt://rabbitmq/files/shovel.sh
    - template: jinja
    - defaults:
      dry_run: {{ opts['test'] }}
    {# - unless: rabbitmqctl eval 'rabbit_shovel_status:status().' | grep running #}
