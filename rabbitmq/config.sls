{% for name, plugin in salt["pillar.get"]("rabbitmq:plugin", {}).items() %}
{{ name }}:
  rabbitmq_plugin:
    {% for value in plugin %}
    - {{ value }}
    {% endfor %}
    - runas: root
    - require:
      - pkg: rabbitmq-server
      - file: rabbitmq_binary_tool_plugins
    - watch_in:
      - service: rabbitmq-server
{% endfor %}
