package Fitzroy::Web::Request;
use warnings;
use strict;

use parent qw/Plack::Request/;

sub new {
    my ($class, $env, $context_class) = @_;
    my $self = $class->SUPER::new($env);
    if (@_==3) {
        $self->{_web_pkg} = $context_class;
    }
    return $self;
}

1;
__END__

