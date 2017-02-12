FROM erlang:latest

ENV TS_PORT 8080
WORKDIR /root/
ADD . ./app/
WORKDIR /root/app/

RUN make all

CMD ./run.escript ${TS_PORT}

EXPOSE ${TS_PORT}
