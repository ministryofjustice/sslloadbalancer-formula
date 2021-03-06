include:
  - nginx
  - repos
  - logstash.client
  - firewall

{% if salt['pillar.get']('deploy:ssl:dhparams') %}
/etc/nginx/dhparams.pem:
  file.managed:
    - user: root
    - group: root
    - mode: 0600
    - contents_pillar: deploy:ssl:dhparams
    - watch_in:
      - service: nginx
{% endif %}


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
{{ logship('sslloadbalancer-access', '/var/log/nginx/ssl.access.json', 'nginx', ['nginx','ssl','loadbalancer','sslloadbalancer','access'], 'rawjson') }}
{{ logship('sslloadbalancer-error', '/var/log/nginx/ssl.error.log', 'nginx', ['nginx','ssl','loadbalancer','sslloadbalancer','error'], 'json') }}


{% from 'firewall/lib.sls' import firewall_enable with  context %}
{{ firewall_enable('nginxlb-https', 443, proto='tcp') }}
