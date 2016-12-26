-module(timeServer).
-export([start/0]).

start() ->
	Pid = spawn(fun loop/0),
	Pid.

loop() -> 
	receive
		{From, _} ->
			From ! timeGenerator:getTime(),
			loop()
	end.
