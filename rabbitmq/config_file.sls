{% set environment = salt['pillar.get']('environment') -%}

rabbitmq_env_file:
  file.managed:
    - name: /etc/rabbitmq/rabbitmq-env.conf
    - source: salt://rabbitmq/files/rabbitmq-env.conf
    - require:
      - pkg: rabbitmq-server
    - watch_in:
       - service: rabbitmq-server

rabbitmq_conf_file:
  file.managed:
    - name: /etc/rabbitmq/rabbitmq.conf
    - source: salt://rabbitmq/files/rabbitmq.conf
    - template: jinja
    - defaults:
        env:  {{ environment }}
    - require:
      - pkg: rabbitmq-server
    - watch_in:
      - service: rabbitmq-server
 
 
erlang_cookie_file:
  file.managed:
    - name: /var/lib/rabbitmq/.erlang.cookie
    - user: rabbitmq
    - group: rabbitmq
    - mode: 0600
    - makedirs: true
    - contents: {{ salt['pillar.get']( 'cookie:' + environment ) }}
    - require:
      - pkg: rabbitmq-server
    - watch_in:
      - service: rabbitmq-server    
