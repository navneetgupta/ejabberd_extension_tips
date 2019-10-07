%% Created automatically by XML generator (fxml_gen.erl)
%% Source: xmpp_codec.spec

-module(ps_publish_new).

-compile(export_all).

do_decode(<<"publish_new">>,
	  <<"http://jabber.org/protocol/pubsub/push">>, El,
	  Opts) ->
    decode_pubsub_publish_new(<<"http://jabber.org/protocol/pubsub/push">>,
			      Opts, El);
do_decode(Name, <<>>, _, _) ->
    erlang:error({xmpp_codec, {missing_tag_xmlns, Name}});
do_decode(Name, XMLNS, _, _) ->
    erlang:error({xmpp_codec, {unknown_tag, Name, XMLNS}}).

tags() ->
    [{<<"publish_new">>,
      <<"http://jabber.org/protocol/pubsub/push">>}].

do_encode({ps_publish_new, _, _} = Publish_new,
	  TopXMLNS) ->
    encode_pubsub_publish_new(Publish_new, TopXMLNS).

do_get_name({ps_publish_new, _, _}) ->
    <<"publish_new">>.

do_get_ns({ps_publish_new, _, _}) ->
    <<"http://jabber.org/protocol/pubsub/push">>.

pp(ps_publish_new, 2) -> [node, items];
pp(_, _) -> no.

records() -> [{ps_publish_new, 2}].

decode_pubsub_publish_new(__TopXMLNS, __Opts,
			  {xmlel, <<"publish_new">>, _attrs, _els}) ->
    Items = decode_pubsub_publish_new_els(__TopXMLNS,
					  __Opts, _els, []),
    Node = decode_pubsub_publish_new_attrs(__TopXMLNS,
					   _attrs, undefined),
    {ps_publish_new, Node, Items}.

decode_pubsub_publish_new_els(__TopXMLNS, __Opts, [],
			      Items) ->
    lists:reverse(Items);
decode_pubsub_publish_new_els(__TopXMLNS, __Opts,
			      [{xmlel, <<"item">>, _attrs, _} = _el | _els],
			      Items) ->
    case xmpp_codec:get_attr(<<"xmlns">>, _attrs,
			     __TopXMLNS)
	of
      <<"http://jabber.org/protocol/pubsub">> ->
	  decode_pubsub_publish_new_els(__TopXMLNS, __Opts, _els,
					[xep0060:decode_pubsub_item(<<"http://jabber.org/protocol/pubsub">>,
								    __Opts, _el)
					 | Items]);
      <<"http://jabber.org/protocol/pubsub#event">> ->
	  decode_pubsub_publish_new_els(__TopXMLNS, __Opts, _els,
					[xep0060:decode_pubsub_item(<<"http://jabber.org/protocol/pubsub#event">>,
								    __Opts, _el)
					 | Items]);
      _ ->
	  decode_pubsub_publish_new_els(__TopXMLNS, __Opts, _els,
					Items)
    end;
decode_pubsub_publish_new_els(__TopXMLNS, __Opts,
			      [_ | _els], Items) ->
    decode_pubsub_publish_new_els(__TopXMLNS, __Opts, _els,
				  Items).

decode_pubsub_publish_new_attrs(__TopXMLNS,
				[{<<"node">>, _val} | _attrs], _Node) ->
    decode_pubsub_publish_new_attrs(__TopXMLNS, _attrs,
				    _val);
decode_pubsub_publish_new_attrs(__TopXMLNS,
				[_ | _attrs], Node) ->
    decode_pubsub_publish_new_attrs(__TopXMLNS, _attrs,
				    Node);
decode_pubsub_publish_new_attrs(__TopXMLNS, [], Node) ->
    decode_pubsub_publish_new_attr_node(__TopXMLNS, Node).

encode_pubsub_publish_new({ps_publish_new, Node, Items},
			  __TopXMLNS) ->
    __NewTopXMLNS =
	xmpp_codec:choose_top_xmlns(<<"http://jabber.org/protocol/pubsub/push">>,
				    [], __TopXMLNS),
    _els =
	lists:reverse('encode_pubsub_publish_new_$items'(Items,
							 __NewTopXMLNS, [])),
    _attrs = encode_pubsub_publish_new_attr_node(Node,
						 xmpp_codec:enc_xmlns_attrs(__NewTopXMLNS,
									    __TopXMLNS)),
    {xmlel, <<"publish_new">>, _attrs, _els}.

'encode_pubsub_publish_new_$items'([], __TopXMLNS,
				   _acc) ->
    _acc;
'encode_pubsub_publish_new_$items'([Items | _els],
				   __TopXMLNS, _acc) ->
    'encode_pubsub_publish_new_$items'(_els, __TopXMLNS,
				       [xep0060:encode_pubsub_item(Items,
								   __TopXMLNS)
					| _acc]).

decode_pubsub_publish_new_attr_node(__TopXMLNS,
				    undefined) ->
    erlang:error({xmpp_codec,
		  {missing_attr, <<"node">>, <<"publish_new">>,
		   __TopXMLNS}});
decode_pubsub_publish_new_attr_node(__TopXMLNS, _val) ->
    _val.

encode_pubsub_publish_new_attr_node(_val, _acc) ->
    [{<<"node">>, _val} | _acc].
