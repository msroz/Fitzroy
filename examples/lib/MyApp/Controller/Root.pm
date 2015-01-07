package MyApp::Controller::Root;
use warnings;
use strict;
use parent qw/Fitzroy::Web::Controller/;

sub echo {
    my ($self, $c) = @_;
    my $message = $c->req->param('message');
    return $self->render('echo.tx', { message => $message });
}

1;

