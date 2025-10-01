{% set dist = salt.grains.get('oscodename') %}

include:
  - rabbitmq

{% if grains['os_family'] == 'Debian' %}
rabbitmq_repo:
  pkgrepo.managed:
    - humanname: RabbitMQ Repository
    - name: deb https://dl.bintray.com/rabbitmq/debian {{ dist }}  main
    - file: /etc/apt/sources.list.d/rabbitmq.list
    - key_url: https://dl.bintray.com/rabbitmq/Keys/rabbitmq-release-signing-key.asc
    - require_in:
      - pkg: rabbitmq-server
erlang_repo:
  pkgrepo.managed:
    - humanname: Erlang Repository
    - name: deb https://dl.bintray.com/rabbitmq/debian {{ dist }}  erlang
    - file: /etc/apt/sources.list.d/rabbitmq.list
    - key_url: https://dl.bintray.com/rabbitmq/Keys/rabbitmq-release-signing-key.asc
    - require_in:
      - pkg: rabbitmq-server
{% elif grains['os'] == 'CentOS' and grains['osmajorrelease'][0] == '6' %}
rabbitmq_repo:
  pkgrepo.managed:
    - humanname: RabbitMQ Packagecloud Repository
    - baseurl: https://packagecloud.io/rabbitmq/rabbitmq-server/el/6/$basearch
    - gpgcheck: 1
    - enabled: True
    - gpgkey: https://packagecloud.io/gpg.key
    - sslverify: 1
    - sslcacert: /etc/pki/tls/certs/ca-bundle.crt
    - require_in:
      - pkg: rabbitmq-server
{% endif %}

