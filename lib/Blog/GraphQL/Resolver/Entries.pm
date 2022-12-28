package Blog::GraphQL::Resolver::Entries;
use v5.36;
use utf8;

use Blog::GraphQL::Type::Entry;

sub resolve {

    [
        Blog::GraphQL::Type::Entry->new,
        Blog::GraphQL::Type::Entry->new,
    ]
}

1;
