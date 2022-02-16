{% set dist = salt.grains.get('oscodename') %}

include:
  - rabbitmq

{% if grains['os_family'] == 'Debian' %}
rabbitmq_repo:
  pkgrepo.managed:
    - humanname: RabbitMQ Repository
    - name: deb https://packagecloud.io/rabbitmq/rabbitmq-server/ubuntu/ {{ dist }} main
    - file: /etc/apt/sources.list.d/rabbitmq.list
    - key_url: https://packagecloud.io/rabbitmq/rabbitmq-server/gpgkey
    - require_in:
      - pkg: rabbitmq-server
erlang_repo:
  pkgrepo.managed:
    - humanname: Erlang Repository
    - name: deb http://ppa.launchpad.net/rabbitmq/rabbitmq-erlang/ubuntu {{ dist }} main
    - file: /etc/apt/sources.list.d/rabbitmq.list
    - key_url: https://keyserver.ubuntu.com/pks/lookup?op=get&search=0xf77f1eda57ebb1cc
    - require_in:
      - pkg: rabbitmq-server
{% endif %}

