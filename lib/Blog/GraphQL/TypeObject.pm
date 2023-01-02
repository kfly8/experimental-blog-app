package Blog::GraphQL::TypeObject;
use v5.36;
use utf8;
use Moo;

has object => (
    is => 'ro',
    required => 1
);

1;
