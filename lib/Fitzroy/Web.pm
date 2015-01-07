package Fitzroy::Web;
use strict;
use warnings;

use Plack::Request;
use Plack::Util;
use Try::Tiny;
use Fitzroy::Web::Request;
use Fitzroy::Web::Response;
use Fitzroy::Web::Dispatcher;
use Fitzroy::Log;

use parent qw/Fitzroy::Base/;

__PACKAGE__->mk_accessors(qw/
    dispatcher
    configure
    container
    logger
/);

sub init {
    my $self = shift;

    $self->dispatcher( Fitzroy::Web::Dispatcher->new );
    $self->logger( Fitzroy::Log->new );
}

sub app {
    my $class = shift;
    return sub { $class->handle_request(shift) };
}

sub req     { $_[0]->{request} }
sub request { $_[0]->{request} }
sub setup { warn "abstract class"; }

sub handle_request {
    my ($class, $env) = @_;

    my $request = $class->create_request($env);
    my $self = $class->new( request => $request);

    $self->setup;

    my $response = $self->before_dispatch();
    goto PROCESS_END if Scalar::Util::blessed($response) && $response->isa('Plack::Response');

    $response = $self->dispatch();

PROCESS_END:
    $self->after_dispatch();

    return $response;
}

sub create_request  { Fitzroy::Web::Request->new($_[1], $_[0]) }
sub create_response { shift; Fitzroy::Web::Response->new(@_) }

sub before_dispatch {
    my $self = shift;
    $self->logger->debugf('before_dispatch');
}

sub after_dispatch {
    my $self = shift;
    $self->logger->debugf('after_dispatch');
}

sub dispatch {
    my $self = shift;
    return $self->dispatcher->dispatch($self);
}

sub res_404 {
    return [404, [], ['Not Found']];
}

sub res_500 {
    return [500, [], ['Internal Server Error']];
}

1;
__END__

=encoding utf-8

=head1 NAME

Fitzroy - It's new $module

=head1 SYNOPSIS

    use Fitzroy;

=head1 DESCRIPTION

Fitzroy is ...

=head1 LICENSE

Copyright (C) msroz.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=head1 AUTHOR

msroz E<lt>masaru95@gmail.comE<gt>

=cut

