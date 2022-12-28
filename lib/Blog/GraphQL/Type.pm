package Blog::GraphQL::Type;
use v5.36;
use utf8;
use Moo;

has graphql_root_value => (is => 'ro');
has graphql_context => (is => 'ro');
has graphql_info => (is => 'ro');

1;
