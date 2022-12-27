use Test2::V0;
use Test::Mojo;

my $t = Test::Mojo->new('Blog::Web');
$t->get_ok('/')
  ->status_is(200)
  ->json_is('/message' => 'HELLO 世界');

done_testing();
