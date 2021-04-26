include:  
  - rabbitmq

create_dynamic_shovel:
  cmd.script:
    - source: salt://rabbitmq/files/shovel.sh
    - unless: rabbitmqctl eval 'rabbit_shovel_status:status().' | grep running
