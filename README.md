# ErlTimeServer

# Summary

Simple server that returns current time in UTC format like "2016-12-25T14:12:33+00:00" (look at [it](http://konh.strangled.net/erlang_time/)).

# API

Request for **/time** returns UTC time in string format.

# Docker support

You can pull and use Docker container with ErlTimeServer:

- Pull: ```docker pull konh/erltimeserver:latest```
- Run: ```docker run -i -t -p 8080:8080 -e TS_PORT=8080 konh/erltimeserver:latest```
