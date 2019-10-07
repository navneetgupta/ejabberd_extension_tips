%% Created automatically by XML generator (fxml_gen.erl)
%% Source: xmpp_codec.spec

-module(pubsub_create_new).

-compile(export_all).

do_decode(<<"create_with_type">>,
	  <<"http://jabber.org/protocol/pubsub/push">>, El,
	  Opts) ->
    decode_pubsub_create_new(<<"http://jabber.org/protocol/pubsub/push">>,
			     Opts, El);
do_decode(<<"create_with_type">>,
	  <<"http://jabber.org/protocol/pubsub/push#event">>, El,
	  Opts) ->
    decode_pubsub_create_new(<<"http://jabber.org/protocol/pubsub/push#event">>,
			     Opts, El);
do_decode(Name, <<>>, _, _) ->
    erlang:error({xmpp_codec, {missing_tag_xmlns, Name}});
do_decode(Name, XMLNS, _, _) ->
    erlang:error({xmpp_codec, {unknown_tag, Name, XMLNS}}).

tags() ->
    [{<<"create_with_type">>,
      <<"http://jabber.org/protocol/pubsub/push">>},
     {<<"create_with_type">>,
      <<"http://jabber.org/protocol/pubsub/push#event">>}].

do_encode({create_with_type, _, _} = Create_with_type,
	  TopXMLNS) ->
    encode_pubsub_create_new(Create_with_type, TopXMLNS).

do_get_name({create_with_type, _, _}) ->
    <<"create_with_type">>.

do_get_ns({create_with_type, _, _}) ->
    <<"http://jabber.org/protocol/pubsub/push">>.

pp(create_with_type, 2) -> [node, type];
pp(_, _) -> no.

records() -> [{create_with_type, 2}].

decode_pubsub_create_new(__TopXMLNS, __Opts,
			 {xmlel, <<"create_with_type">>, _attrs, _els}) ->
    {Node, Type} =
	decode_pubsub_create_new_attrs(__TopXMLNS, _attrs,
				       undefined, undefined),
    {create_with_type, Node, Type}.

decode_pubsub_create_new_attrs(__TopXMLNS,
			       [{<<"node">>, _val} | _attrs], _Node, Type) ->
    decode_pubsub_create_new_attrs(__TopXMLNS, _attrs, _val,
				   Type);
decode_pubsub_create_new_attrs(__TopXMLNS,
			       [{<<"type">>, _val} | _attrs], Node, _Type) ->
    decode_pubsub_create_new_attrs(__TopXMLNS, _attrs, Node,
				   _val);
decode_pubsub_create_new_attrs(__TopXMLNS, [_ | _attrs],
			       Node, Type) ->
    decode_pubsub_create_new_attrs(__TopXMLNS, _attrs, Node,
				   Type);
decode_pubsub_create_new_attrs(__TopXMLNS, [], Node,
			       Type) ->
    {decode_pubsub_create_new_attr_node(__TopXMLNS, Node),
     decode_pubsub_create_new_attr_type(__TopXMLNS, Type)}.

encode_pubsub_create_new({create_with_type, Node, Type},
			 __TopXMLNS) ->
    __NewTopXMLNS = xmpp_codec:choose_top_xmlns(<<>>,
						[<<"http://jabber.org/protocol/pubsub/push">>,
						 <<"http://jabber.org/protocol/pubsub/push#event">>],
						__TopXMLNS),
    _els = [],
    _attrs = encode_pubsub_create_new_attr_type(Type,
						encode_pubsub_create_new_attr_node(Node,
										   xmpp_codec:enc_xmlns_attrs(__NewTopXMLNS,
													      __TopXMLNS))),
    {xmlel, <<"create_with_type">>, _attrs, _els}.

decode_pubsub_create_new_attr_node(__TopXMLNS,
				   undefined) ->
    <<>>;
decode_pubsub_create_new_attr_node(__TopXMLNS, _val) ->
    _val.

encode_pubsub_create_new_attr_node(<<>>, _acc) -> _acc;
encode_pubsub_create_new_attr_node(_val, _acc) ->
    [{<<"node">>, _val} | _acc].

decode_pubsub_create_new_attr_type(__TopXMLNS,
				   undefined) ->
    <<>>;
decode_pubsub_create_new_attr_type(__TopXMLNS, _val) ->
    _val.

encode_pubsub_create_new_attr_type(<<>>, _acc) -> _acc;
encode_pubsub_create_new_attr_type(_val, _acc) ->
    [{<<"type">>, _val} | _acc].
