-module(evserv).
-compile(export_all).

loop(State) ->
    receive 
        {Pid, MsgRef, {subscribe, Client}} ->
            not_implemented;
        {Pid, MsgRef, {add, Name, Description, TimeOut}} ->
            not_implemented;
        {Pid, MsgRef, {cancel, Name}} ->
            not_implemented;
        {done, Name} ->
            not_implemented;
        shutdown ->
            not_implemented;
        {'DOWN', Ref, process, _Pid, _Reason} ->
            not_implemented;
        code_change ->
            not_implemented;
        Unknown ->
            io:format("Unknown message: ~p~n", [Unknown])
    end.
