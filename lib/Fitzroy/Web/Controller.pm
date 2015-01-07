package Fitzroy::Web::Controller;
use strict;
use warnings;
use Encode;
use Path::Tiny;

use Text::Xslate;
use parent qw/Fitzroy::Base/;

__PACKAGE__->mk_accessors(qw/
    _xslate
/);

sub init {
    my $self = shift;

    $self->_xslate(Text::Xslate->new());
}

sub render {
    my ($self, $file, $args) = @_;
    my ($p, $f, $l) = caller;
    my $dir = path($f)->parent(4)->child('templates');

    my $html = $self->_xslate->render($dir->child($file), $args);
    return [
        200,
        [ 'Content-Length' => length($html), 'Content-Type' => 'text/html' ],
        [ encode_utf8($html) ],
    ];
}

1;

