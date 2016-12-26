-module(localClient).
-export([ask/1]).

ask(Pid) ->
	Pid ! {self(), {}}.
