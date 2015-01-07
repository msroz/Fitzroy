requires 'perl', '5.008001';
requires 'Class::Accessor::Lite';
requires 'Log::Minimal::Instance';
requires 'Encode';
requires 'Path::Tiny';
requires 'Plack::Request';
requires 'Plack::Util';
requires 'Router::Boom::Method';
requires 'Text::Xslate';
requires 'Try::Tiny';

on 'test' => sub {
    requires 'Test::More', '0.98';
};

