package Blog::GraphQL::Resolver::GreateEntry;
use v5.36;
use utf8;

use Blog::GraphQL::Type::Payload::GreateEntry;

sub resolve {

    Blog::GraphQL::Type::Payload::GreateEntry->new;
}

1;
