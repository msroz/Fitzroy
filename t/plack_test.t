use strict;
use warnings;
use lib 't/testapp/lib';
use TestApp;
use Plack::Test;
use HTTP::Request::Common;
use Test::More;

my $app = TestApp->app();
ok $app;

my $test = Plack::Test->create($app);
my $res = $test->request(GET '/');
is $res->code, 200;
is $res->content, 'Hello';

$res = $test->request(GET '/render');
is $res->code, 200;
is $res->content, 'Hello';

done_testing;

