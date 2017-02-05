-module(timeServer).
-export([start/0, ask/0, stop/0]).

start() ->
	Pid = spawn(fun loop/0),
	onExit(Pid, fun onWorkerExit/2),
	register(timeServerWorker, Pid),
	Pid.

onExit(Pid, Fun) ->
	spawn(fun() ->
		process_flag(trap_exit, true),
		link(Pid),
		receive
		{'EXIT', Pid, Why} ->
			Fun(Pid, Why)
		end
	end).

onWorkerExit(Pid, Why) ->
	io:format("Worker ~p died with:~p~n",[Pid, Why]),
	case Why of 
		normal ->
			io:format('Server is stopped.~n');
		_ ->
			io:format('Restarting server.~n'),
			NewPid = start(),
			io:format('New pid: ~p~n', [NewPid])
	end.


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
			exit(error);
		_ ->
			exit(error)
	end.

ask() ->
	workerRpc(time).

stop() ->
	workerRpc(stop).

workerRpc(Request) ->
	commonUtils:rpcByName(timeServerWorker, Request, 1000).
