{% from "rabbitmq/package-map.jinja" import pkgs with context %}

{% set module_list = salt['sys.list_modules']() %}
{% if 'rabbitmqadmin' in module_list %}
include:
  - .config_bindings
  - .config_queue
  - .config_exchange
{% endif %}

rabbitmq-server:
  pkg.installed:
    - name: {{ pkgs['rabbitmq-server'] }}
    {%- if 'version' in salt['pillar.get']('rabbitmq', {}) %}
    - version: {{ salt['pillar.get']('rabbitmq:version') }}
    {%- endif %}
    {%- if 'hold' in salt['pillar.get']('rabbitmq', {}) %}
    - hold: {{ salt['pillar.get']('rabbitmq:hold') }}
    {%- endif %}

  service:
    - {{ "running" if salt['pillar.get']('rabbitmq:running', True) else "dead" }}
    - enable: {{ salt['pillar.get']('rabbitmq:enabled', True) }}
    - watch:
      - pkg: rabbitmq-server

rabbitmq_binary_tool_env:
  file.symlink:
    - makedirs: True
    - name: /usr/local/bin/rabbitmq-env
    - target: /usr/lib/rabbitmq/bin/rabbitmq-env
    - require:
      - pkg: rabbitmq-server

rabbitmq_binary_tool_plugins:
  file.symlink:
    - makedirs: True
    - name: /usr/local/bin/rabbitmq-plugins
    - target: /usr/lib/rabbitmq/bin/rabbitmq-plugins
    - require:
      - pkg: rabbitmq-server
      - file: rabbitmq_binary_tool_env

