-module(timeServer).
-export([start/0, ask/1, stop/1]).

start() ->
	Pid = spawn(fun loop/0),
	Pid.

loop() -> 
	receive
		{From, time} ->
			From ! {self(), timeGenerator:getTime()},
			loop();
		{From, stop} ->
			From ! {self(), exit},
			exit(normal);
		{From, Other} ->
			From ! {self(), {error, Other}},
			loop()
	end.

ask(Pid) ->
	rpc(Pid, time, 1000).

stop(Pid) ->
	rpc(Pid, stop, 1000).

rpc(Pid, Request, Timeout) ->
	Pid ! {self(), Request},
	receive
		{Pid, Response} ->
			Response
	after Timeout ->
		io:fwrite('Timeout.')
	end.
