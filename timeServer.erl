-module(timeServer).
-export([start/0, ask/1]).

start() ->
	Pid = spawn(fun loop/0),
	Pid.

loop() -> 
	receive
		{From, time} ->
			From ! {self(), timeGenerator:getTime()},
			loop();
		{From, Other} ->
			From ! {self(), {error, Other}},
			loop()
	end.

ask(Pid) ->
	rpc(Pid, time).

rpc(Pid, Request) ->
	Pid ! {self(), Request},
	receive
		{Pid, Response} ->
			Response
	end.
