package Fitzroy::Web::Router;
use strict;
use warnings;

use parent qw/Router::Boom::Method/;

sub get {
    my $self = shift;
    $self->add('GET', @_);
}

sub post {
    my $self = shift;
    $self->add('POST', @_);
}

1;

