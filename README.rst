requires dsd package for sticky sessions:
nginx-full




pillar::

    nginx:
        loadbalancers:
            lbfront:
                - 1.2.3.4:80

    deploy:
        ssl:
            key: bla
            crt: |
                bla
                bla
