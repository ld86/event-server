-module(event).
-compile(export_all).
-record(state, {server, name="", to_go=0}).

start(EventName, Delay) ->
    spawn(?MODULE, init, [self(), EventName, Delay]).

start_link(EventName, Delay) ->
    spawn_link(?MODULE, init, [self(), EventName, Delay]).

init(Server, EventName, Delay) ->
    loop(#state{server=Server, name=EventName, to_go=Delay}).

cancel(Pid) ->
    Ref = erlang:monitor(process, Pid),
    Pid ! {self(), Ref, cancel},
    receive
        {Ref, ok} ->
            erlang:demonitor(Ref, [flush]),
            ok;
        {'DOWN', Ref, process, Pid, _Reason} ->
            ok
    end.

loop(S = #state{server=Server}) ->
    receive
        {Server, Ref, cancel} ->
            Server ! {Ref, ok}
    after timer:seconds(S#state.to_go) ->
        Server ! {done, S#state.name}
    end.
