## CURRENT

* Enable http/https redirection to a canonical_host

## Version 2.1.0

* Disable SSLv3 due to poodlebleed

## Version 2.0.0

* Pass through real_ip, real_forwarded_for, real_forwarded_proto, $http_host (not $host)
* Allow to specify port for http->https redirect (forces pillar update)

## Version 1.0.1

* Don't log at notice level in error logs - too noisy
* SSL termination access logs in logstash-friendly json format

## Version 1.0.0

* Initial release
