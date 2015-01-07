package MyApp;
use parent qw/Fitzroy::Web/;

sub setup {
    my $self = shift;
    $self->dispatcher->router->get('/echo', { controller => 'Root', action => 'echo' });
}

1;

