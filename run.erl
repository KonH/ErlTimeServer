#!/usr/bin/env escript
main([String]) ->
	try
		Port = list_to_integer(String),
		Pid = timeWebServer:start(Port),
		io:format("Started: ~w\n", [Pid]),
		loop()
	catch
		_:_ ->
			usage()
	end;

main(_) ->
	usage().

usage() ->
	io:format("usage: port integer\n"),
	halt(1).

loop() ->
	loop().
