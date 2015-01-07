package Fitzroy::Log;
use warnings;
use strict;

use parent 'Log::Minimal::Instance';
use Log::Minimal qw//;

sub new {
    my ($class, %args) = @_;
    my $config = { %args };

    if ( ( $config->{level} || '' ) eq 'DEBUG' ) {
        $ENV{LM_DEBUG} = 1;
    }
    my $self = $class->SUPER::new(%{$config});
    return $self;
}

sub dd {
    my ($self, $args) = @_;
    return Log::Minimal::ddf($args);
}

1;

