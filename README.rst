sslloadbalancer-formula
=======================


requirements
------------
requires dsd package for sticky sessions:
nginx-full


ciphers
-------
The list of SSL cipher suite we use and thier ordering has been taken from mozilla_'s wiki:
.. _mozilla: https://wiki.mozilla.org/Security/Server_Side_TLS#Nginx_configuration_details


pillar
------
parameters::

    nginx:
        loadbalancers:
            front:
                https_port: 8443 (used if you hit http port to redirect user to https port - defaults to 443, usefull if your user sees your site on different port (i.e. on vagrant))
                servers: (list of servers to loadbalance over)
                    - 127.0.0.1:81

    deploy:
        ssl:
            key: (your key)
            dhparams: |
                (your dhparams - optional)
            crt: |
                (your certificate)



example
-------
example pillar::

    nginx:
        loadbalancers:
            front:
                servers:
                    - 1.2.3.4:80

    deploy:
        ssl:
            key: bla
            dhparams: |
                -----BEGIN DH PARAMETERS-----
                MIIB0123...
            crt: |
                bla
                bla


example pillar for vagrant::

    nginx:
        loadbalancers:
            front:
                https_port: 8443
                servers:
                    - 127.0.0.1:81

    deploy:
        ssl:
            key: bla
            dhparams: |
                -----BEGIN DH PARAMETERS-----
                MIIB0123...
            crt: |
                bla
                bla
