-module(mod_pubsub_push).
-author("Navneet Gupta <navneetpgupta@gmail.com>").

-include("logger.hrl").
-include("xmpp.hrl").
-include("pubsub.hrl").
-include("pubsub_custom.hrl").
-include("translate.hrl").
-include("ejabberd_stacktrace.hrl").

-define(PUSHNODE, <<"push">>).

-behaviour(gen_mod).

-export([start/2, stop/1, reload/3, depends/2, mod_options/1]).
-export([process_pubsub/1, iq_sm/1]).


start(Host, _Opts) ->
	register_codecs(),
	ServerHost = mod_pubsub:serverhost(Host),
	Opts1 = gen_mod:get_module_opts(ServerHost, mod_pubsub),
	Hosts = gen_mod:get_opt_hosts(Opts1),
	lists:foreach(fun(Host) ->
		?INFO_MSG("mod_pubsub_push:start Host ~p", [Host]),
		gen_iq_handler:add_iq_handler(ejabberd_local, Host, ?NS_PUBSUB_PUSH,
					?MODULE, process_pubsub)
	end, Hosts),
	gen_iq_handler:add_iq_handler(ejabberd_sm, ServerHost,
		?NS_PUBSUB_PUSH, ?MODULE, iq_sm).

stop(Host) ->
	unregister_codecs(),
	ServerHost = mod_pubsub:serverhost(Host),
	gen_iq_handler:remove_iq_handler(ejabberd_local, Host, ?NS_PUBSUB_PUSH,
					?MODULE, process_pubsub),
	gen_iq_handler:remove_iq_handler(ejabberd_sm, ServerHost,
		?NS_PUBSUB_PUSH, ?MODULE, iq_sm).

reload(_Host, _NewOpts, _OldOpts) ->
	ok.

depends(_Host, _Opts) ->
  [{mod_pubsub, hard}].

mod_options(_Host) -> [].

register_codecs() ->
	xmpp:register_codec(pubsub_new),
	xmpp:register_codec(pubsub_create_new).

unregister_codecs() ->
	xmpp:unregister_codec(pubsub_new),
	xmpp:unregister_codec(pubsub_create_new).

process_pubsub(#iq{to = To} = IQ) ->
	?INFO_MSG("mod_pubsub_push:process_pubsub processs IQ ~p", [IQ]),
	Host = To#jid.lserver,
	ServerHost = ejabberd_router:host_of_route(Host),
	Access = config(ServerHost, access),
	case iq_pubsub(Host, Access, IQ) of
	{result, IQRes} ->
		xmpp:make_iq_result(IQ, IQRes);
	{error, Error} ->
		xmpp:make_error(IQ, Error)
	end.

-spec iq_sm(iq()) -> iq().
iq_sm(#iq{to = To, sub_els = [SubEl]} = IQ) ->
		?INFO_MSG("mod_pubsub_push:iq_sm processs IQ ~p", [IQ]),
    LOwner = jid:tolower(jid:remove_resource(To)),
    case xmpp:get_ns(SubEl) of
	      ?NS_PUBSUB_PUSH ->
		  		case iq_pubsub(LOwner, all, IQ) of
						{result, IQRes} ->
						    xmpp:make_iq_result(IQ, IQRes);
						{error, Error} ->
						    xmpp:make_error(IQ, Error)
					end;
	      ?NS_PUBSUB_OWNER ->
		  		IQ
	  end.

-spec iq_pubsub(binary() | ljid(), atom(), iq()) ->
		       {result, pubsub()} | {error, stanza_error()}.
iq_pubsub(Host, Access, #iq{from = From, type = set, lang = Lang,
				    sub_els = [#pubsub_new{create_with_type = #create_with_type{node = Node, type = Type},
								configure = Configure, _ = undefined}]}) ->
		?INFO_MSG("mod_pubsub_push:iq_pubsub create", []),
		ServerHost = mod_pubsub:serverhost(Host),
    Plugins = config(ServerHost, plugins),
    Config = case Configure of
		 {_, XData} -> mod_pubsub:decode_node_config(XData, Host, Lang);
		 undefined -> []
	     end,
    case Config of
	{error, _} = Err ->
	    Err;
	_ ->
		case lists:member(Type, Plugins) of
			false ->
          {error, xmpp:err_feature_not_implemented()};
      true ->
          mod_pubsub:create_node(Host, ServerHost, Node, From, Type, Access, Config)
  	end
	end;
iq_pubsub(Host, Access, #iq{from = From, type = set, lang = Lang,
					sub_els = [#pubsub_new{publish_new = #ps_publish_new{node = Node, items = Items},
									publish_options = XData, configure = _, _ = undefined}]}) ->
		?INFO_MSG("mod_pubsub_push:iq_pubsub pusblish", []),
		ServerHost = mod_pubsub:serverhost(Host),
		case Items of
	[#ps_item{id = ItemId, sub_els = Payload}] ->
			PubOpts =  decode_publish_custom_options(XData, Lang),
			mod_pubsub:publish_item(Host, ServerHost, Node, From, ItemId,
				 Payload, PubOpts, Access);
	[] ->
			mod_pubsub:publish_item(Host, ServerHost, Node, From, <<>>, [], [], Access);
	_ ->
			{error, mod_pubsub:extended_error(xmpp:err_bad_request(), mod_pubsub:err_invalid_payload())}
		end;

iq_pubsub(Host, Access, IQ) -> {error, xmpp:err_feature_not_implemented()}.
%%--------------------------------------------------------------------
%%% Internal functions
%%--------------------------------------------------------------------
-spec config(binary(), any()) -> any().
config(ServerHost, Key) ->
    config(ServerHost, Key, undefined).

-spec config(host(), any(), any()) -> any().
config({_User, Host, _Resource}, Key, Default) ->
    config(Host, Key, Default);
config(ServerHost, Key, Default) ->
    case catch ets:lookup(gen_mod:get_module_proc(ServerHost, config), Key) of
	[{Key, Value}] -> Value;
	_ -> Default
    end.

-spec decode_publish_custom_options(undefined | xdata(), binary()) ->
					    pubsub_publish_options:result() |
					    {error, stanza_error()}.
decode_publish_custom_options(undefined, _) ->
    [];
decode_publish_custom_options(#xdata{} = X, _Lang) ->
  [{service, xmpp_util:get_xdata_values(<<"service">>, X)},
	 {device_id, xmpp_util:get_xdata_values(<<"device_id">>, X)},
	 {silent, xmpp_util:get_xdata_values(<<"silent">>, X)},
	 {topic, xmpp_util:get_xdata_values(<<"topic">>, X)},
	 {click_action, xmpp_util:get_xdata_values(<<"click_action">>, X)}].
