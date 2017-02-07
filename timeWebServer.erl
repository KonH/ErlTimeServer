-module(timeWebServer).
-export([start/1, stop/0, time/3]).

start(Port) ->
	inets:start(),
	{ok, Pid} = 
		inets:start(
			httpd,
			[
				{port, Port},
				{server_name, "timeWebServer"}, 
				{server_root,"."},
				{document_root,"."},
				{modules,[mod_esi]},
				{erl_script_alias, {"/time", [timeWebServer]}},
				{bind_address, "localhost"}
			]),
	Pid.

stop() ->
	inets:stop().

time(SessID, _Env, _Input) ->
	Time = timeGenerator:getTime(),
	ok = mod_esi:deliver(SessID, [Time]).
