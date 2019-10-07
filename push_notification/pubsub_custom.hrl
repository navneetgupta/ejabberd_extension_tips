-record(create_with_type, {node = <<>> :: binary(),
                           type = <<>> :: binary()}).
-type create_with_type() :: #create_with_type{}.
-record(ps_publish_new, {node = <<>> :: binary(),
                         items = [] :: [#ps_item{}]}).
-type ps_publish_new() :: #ps_publish_new{}.

-record(pubsub_new, {configure :: 'undefined' | {binary(),'undefined' | #xdata{}},
                     create_with_type :: 'undefined' | #create_with_type{},
                     publish_new :: 'undefined' | #ps_publish_new{},
                     publish_options :: 'undefined' | #xdata{}}).
-type pubsub_new() :: #pubsub_new{}.

-define(NS_PUBSUB_PUSH, <<"http://jabber.org/protocol/pubsub/push">>).
