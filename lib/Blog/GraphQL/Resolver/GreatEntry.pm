package Blog::GraphQL::Resolver::GreatEntry;
use v5.36;
use utf8;

use Blog::GraphQL::Type::Payload::GreatEntry;

sub resolve {

    Blog::GraphQL::Type::Payload::GreatEntry->new;
}

1;
