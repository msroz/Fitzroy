package Fitzroy::Web::Dispatcher;
use strict;
use warnings;

use Fitzroy::Web::Router;

use parent qw/Fitzroy::Base/;

__PACKAGE__->mk_accessors(qw/
    router
    controllers
/);

my $CONTROLLERS = +{};

sub init {
    my $self = shift;
    my %args = @_ == 1 && ref $_[0] eq 'HASH' ? %{ $_[0] } : @_;

    $self->router( $args{router} || Fitzroy::Web::Router->new );
    $self->controllers($CONTROLLERS);
}

sub dispatch {
    my ($self, $c) = @_;

    my $env = $c->req->env;

    my ($dest, $captured, $is_not_allowed)
        = $self->router->match($env->{REQUEST_METHOD}, $env->{PATH_INFO});

    return $c->res_404 if (!$dest || $is_not_allowed);

    my $class = $self->controllers->{$dest->{controller}};
    unless ($class) {
        $class = Plack::Util::load_class("Controller::$dest->{controller}", ref $c);
         $self->controllers->{$dest->{controller}} = $class;
    }
    my $method = $dest->{action};
    my $code = eval {
        my $instance = $class->new();
        warn sprintf("%s#%s", ref $instance, $method);
        $instance->$method($c);
    };
    if (my $e = $@) {
        warn $e;
        return $c->res_500;
    }

    return $code;
}

1;

