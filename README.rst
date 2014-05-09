requires dsd package for sticky sessions:
nginx-full


The list of SSL cipher suite we use and thier ordering has been taken from mozilla_'s wiki:

.. _mozilla: https://wiki.mozilla.org/Security/Server_Side_TLS#Nginx_configuration_details

pillar::

    nginx:
        loadbalancers:
            lbfront:
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
