package TestApp::Controller::Root;
use warnings;
use strict;

use parent qw/Fitzroy::Web::Controller/;

sub index {
    return [200, [], ['Hello']];
}

sub template {
    my $self = shift;
    return $self->render('test.tx', { message => 'Hello' });
}

1;

