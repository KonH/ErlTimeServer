-module(commonUtils).
-export([rpc/3, rpcByName/3]).

rpc(Pid, Request, Timeout) ->
	Pid ! {self(), Request},
	receive
		{Pid, Response} ->
			Response
	after Timeout ->
		io:fwrite('Timeout.')
	end.

rpcByName(Name, Request, Timeout) ->
	Pid = whereis(Name),
	case Pid of
		undefined ->
			io:format('Pid not found.~n');
		_ ->
			commonUtils:rpc(Pid, Request, Timeout)
	end.
