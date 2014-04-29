include:
  - nginx
  - repos
  - logstash.client
  - firewall


/etc/ssl/certs/ssl.key:
  file:
    - managed
    - user: root
    - group: root
    - mode: 644
    - contents_pillar: deploy:ssl:key
    - watch_in:
      - service: nginx


/etc/ssl/certs/ssl.crt:
  file:
    - managed
    - user: root
    - group: root
    - mode: 644
    - contents_pillar: deploy:ssl:crt
    - watch_in:
      - service: nginx


/etc/nginx/conf.d/sslloadbalancer.conf:
  file:
    - managed
    - source: salt://sslloadbalancer/templates/sslloadbalancer.conf
    - template: jinja
    - user: root
    - group: root
    - mode: 644
    - watch_in:
      - service: nginx


{% from 'logstash/lib.sls' import logship with context %}
{{ logship('nginx-ssl-access.log', '/var/log/nginx/ssl.access.log', 'nginx', ['nginx','ssl','loadbalancer','sslloadbalancer','access'], 'rawjson') }}
{{ logship('nginx-ssl-error.log', '/var/log/nginx/ssl.error.log', 'nginx', ['nginx','ssl','loadbalancer','sslloadbalancer','error'], 'json') }}


{% from 'firewall/lib.sls' import firewall_enable with  context %}
{{ firewall_enable('nginxlb-https', 443, proto='tcp') }}
