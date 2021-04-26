sysctl_config:
  file.managed:
    - name: /etc/sysctl.d/01-rabbit.conf
    - source: salt://rabbitmq/files/sysctl-rabbit.conf
    - require:
      - pkg: rabbitmq-server

reload_config:
  cmd.run:
    - name: sysctl -p /etc/sysctl.d/01-rabbit.conf
    - onchanges:
      - file: /etc/sysctl.d/01-rabbit.conf
