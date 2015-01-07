package TestApp;
use warnings;
use strict;
use parent qw/Fitzroy::Web/;

sub setup {
    my $self = shift;
    $self->dispatcher->router->get('/',       { controller => 'Root', action => 'index'    });
    $self->dispatcher->router->get('/render', { controller => 'Root', action => 'template' });
}

1;
__END__
