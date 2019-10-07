%% Created automatically by XML generator (fxml_gen.erl)
%% Source: xmpp_codec.spec

-module(pubsub_new).

-compile(export_all).

do_decode(<<"pubsub_new">>,
	  <<"http://jabber.org/protocol/pubsub/push">>, El,
	  Opts) ->
    decode_pubsub_new(<<"http://jabber.org/protocol/pubsub/push">>,
		      Opts, El);
do_decode(Name, <<>>, _, _) ->
    erlang:error({xmpp_codec, {missing_tag_xmlns, Name}});
do_decode(Name, XMLNS, _, _) ->
    erlang:error({xmpp_codec, {unknown_tag, Name, XMLNS}}).

tags() ->
    [{<<"pubsub_new">>,
      <<"http://jabber.org/protocol/pubsub/push">>}].

do_encode({pubsub_new, _, _, _, _} = Pubsub_new,
	  TopXMLNS) ->
    encode_pubsub_new(Pubsub_new, TopXMLNS).

do_get_name({pubsub_new, _, _, _, _}) ->
    <<"pubsub_new">>.

do_get_ns({pubsub_new, _, _, _, _}) ->
    <<"http://jabber.org/protocol/pubsub/push">>.

pp(pubsub_new, 4) ->
    [configure, create_with_type, publish_new,
     publish_options];
pp(_, _) -> no.

records() -> [{pubsub_new, 4}].

decode_pubsub_new(__TopXMLNS, __Opts,
		  {xmlel, <<"pubsub_new">>, _attrs, _els}) ->
    {Publish_options, Configure, Create_with_type,
     Publish_new} =
	decode_pubsub_new_els(__TopXMLNS, __Opts, _els,
			      undefined, undefined, undefined, undefined),
    {pubsub_new, Configure, Create_with_type, Publish_new,
     Publish_options}.

decode_pubsub_new_els(__TopXMLNS, __Opts, [],
		      Publish_options, Configure, Create_with_type,
		      Publish_new) ->
    {Publish_options, Configure, Create_with_type,
     Publish_new};
decode_pubsub_new_els(__TopXMLNS, __Opts,
		      [{xmlel, <<"create_with_type">>, _attrs, _} = _el
		       | _els],
		      Publish_options, Configure, Create_with_type,
		      Publish_new) ->
    case xmpp_codec:get_attr(<<"xmlns">>, _attrs,
			     __TopXMLNS)
	of
      <<"http://jabber.org/protocol/pubsub/push">> ->
	  decode_pubsub_new_els(__TopXMLNS, __Opts, _els,
				Publish_options, Configure,
				pubsub_create_new:decode_pubsub_create_new(<<"http://jabber.org/protocol/pubsub/push">>,
									   __Opts,
									   _el),
				Publish_new);
      <<"http://jabber.org/protocol/pubsub/push#event">> ->
	  decode_pubsub_new_els(__TopXMLNS, __Opts, _els,
				Publish_options, Configure,
				pubsub_create_new:decode_pubsub_create_new(<<"http://jabber.org/protocol/pubsub/push#event">>,
									   __Opts,
									   _el),
				Publish_new);
      _ ->
	  decode_pubsub_new_els(__TopXMLNS, __Opts, _els,
				Publish_options, Configure, Create_with_type,
				Publish_new)
    end;
decode_pubsub_new_els(__TopXMLNS, __Opts,
		      [{xmlel, <<"configure">>, _attrs, _} = _el | _els],
		      Publish_options, Configure, Create_with_type,
		      Publish_new) ->
    case xmpp_codec:get_attr(<<"xmlns">>, _attrs,
			     __TopXMLNS)
	of
      <<"http://jabber.org/protocol/pubsub">> ->
	  decode_pubsub_new_els(__TopXMLNS, __Opts, _els,
				Publish_options,
				xep0060:decode_pubsub_configure(<<"http://jabber.org/protocol/pubsub">>,
								__Opts, _el),
				Create_with_type, Publish_new);
      <<"http://jabber.org/protocol/pubsub#owner">> ->
	  decode_pubsub_new_els(__TopXMLNS, __Opts, _els,
				Publish_options,
				xep0060:decode_pubsub_configure(<<"http://jabber.org/protocol/pubsub#owner">>,
								__Opts, _el),
				Create_with_type, Publish_new);
      _ ->
	  decode_pubsub_new_els(__TopXMLNS, __Opts, _els,
				Publish_options, Configure, Create_with_type,
				Publish_new)
    end;
decode_pubsub_new_els(__TopXMLNS, __Opts,
		      [{xmlel, <<"publish_new">>, _attrs, _} = _el | _els],
		      Publish_options, Configure, Create_with_type,
		      Publish_new) ->
    case xmpp_codec:get_attr(<<"xmlns">>, _attrs,
			     __TopXMLNS)
	of
      <<"http://jabber.org/protocol/pubsub/push">> ->
	  decode_pubsub_new_els(__TopXMLNS, __Opts, _els,
				Publish_options, Configure, Create_with_type,
				ps_publish_new:decode_pubsub_publish_new(<<"http://jabber.org/protocol/pubsub/push">>,
									 __Opts,
									 _el));
      _ ->
	  decode_pubsub_new_els(__TopXMLNS, __Opts, _els,
				Publish_options, Configure, Create_with_type,
				Publish_new)
    end;
decode_pubsub_new_els(__TopXMLNS, __Opts,
		      [{xmlel, <<"publish-options">>, _attrs, _} = _el
		       | _els],
		      Publish_options, Configure, Create_with_type,
		      Publish_new) ->
    case xmpp_codec:get_attr(<<"xmlns">>, _attrs,
			     __TopXMLNS)
	of
      <<"http://jabber.org/protocol/pubsub">> ->
	  decode_pubsub_new_els(__TopXMLNS, __Opts, _els,
				xep0060:decode_pubsub_publish_options(<<"http://jabber.org/protocol/pubsub">>,
								      __Opts,
								      _el),
				Configure, Create_with_type, Publish_new);
      _ ->
	  decode_pubsub_new_els(__TopXMLNS, __Opts, _els,
				Publish_options, Configure, Create_with_type,
				Publish_new)
    end;
decode_pubsub_new_els(__TopXMLNS, __Opts, [_ | _els],
		      Publish_options, Configure, Create_with_type,
		      Publish_new) ->
    decode_pubsub_new_els(__TopXMLNS, __Opts, _els,
			  Publish_options, Configure, Create_with_type,
			  Publish_new).

encode_pubsub_new({pubsub_new, Configure,
		   Create_with_type, Publish_new, Publish_options},
		  __TopXMLNS) ->
    __NewTopXMLNS =
	xmpp_codec:choose_top_xmlns(<<"http://jabber.org/protocol/pubsub/push">>,
				    [], __TopXMLNS),
    _els =
	lists:reverse('encode_pubsub_new_$publish_options'(Publish_options,
							   __NewTopXMLNS,
							   'encode_pubsub_new_$configure'(Configure,
											  __NewTopXMLNS,
											  'encode_pubsub_new_$create_with_type'(Create_with_type,
																__NewTopXMLNS,
																'encode_pubsub_new_$publish_new'(Publish_new,
																				 __NewTopXMLNS,
																				 []))))),
    _attrs = xmpp_codec:enc_xmlns_attrs(__NewTopXMLNS,
					__TopXMLNS),
    {xmlel, <<"pubsub_new">>, _attrs, _els}.

'encode_pubsub_new_$publish_options'(undefined,
				     __TopXMLNS, _acc) ->
    _acc;
'encode_pubsub_new_$publish_options'(Publish_options,
				     __TopXMLNS, _acc) ->
    [xep0060:encode_pubsub_publish_options(Publish_options,
					   __TopXMLNS)
     | _acc].

'encode_pubsub_new_$configure'(undefined, __TopXMLNS,
			       _acc) ->
    _acc;
'encode_pubsub_new_$configure'(Configure, __TopXMLNS,
			       _acc) ->
    [xep0060:encode_pubsub_configure(Configure, __TopXMLNS)
     | _acc].

'encode_pubsub_new_$create_with_type'(undefined,
				      __TopXMLNS, _acc) ->
    _acc;
'encode_pubsub_new_$create_with_type'(Create_with_type,
				      __TopXMLNS, _acc) ->
    [pubsub_create_new:encode_pubsub_create_new(Create_with_type,
						__TopXMLNS)
     | _acc].

'encode_pubsub_new_$publish_new'(undefined, __TopXMLNS,
				 _acc) ->
    _acc;
'encode_pubsub_new_$publish_new'(Publish_new,
				 __TopXMLNS, _acc) ->
    [ps_publish_new:encode_pubsub_publish_new(Publish_new,
					      __TopXMLNS)
     | _acc].
