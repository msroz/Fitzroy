use strict;
use Test::More 0.98;

use_ok $_ for qw(
    Fitzroy
    Fitzroy::Base
    Fitzroy::Log
    Fitzroy::Web
    Fitzroy::Web::Dispatcher
    Fitzroy::Web::Router
    Fitzroy::Web::Controller
    Fitzroy::Web::Response
    Fitzroy::Web::Request
);

done_testing;

