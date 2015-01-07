package Fitzroy::Base;
use strict;
use warnings;

use parent qw/Class::Accessor::Lite/;

sub new {
    my $class = shift;
    my $self = bless {
        ( (@_ == 1) && (ref $_[0] eq 'HASH') ) ? %{$_[0]} : @_,
    }, $class;

    if ( $self->can('init') ) {
        $self->init;
    }

    return $self;
}

1;
__END__

