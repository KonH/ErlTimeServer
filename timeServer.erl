-module(timeServer).
-export([getTime/0]).

getTime() ->
	getTextTime().

getTextTime() -> 
	{Date, Time} = getRawTime(),
	{Year, Month, Day} = Date,
	{Hour, Minute, Second} = Time,
	io:format(
	  '~4..0b-~2..0b-~2..0bT~2..0b:~2..0b:~2..0b+00:00', 
	  [Year, Month, Day, Hour, Minute, Second]).

getRawTime() ->
	calendar:universal_time().
