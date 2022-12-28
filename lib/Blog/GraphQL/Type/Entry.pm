package Blog::GraphQL::Type::Entry;
use v5.36;
use utf8;
use Moo;
extends qw(Blog::GraphQL::Type);

sub title {
    'waiwai'
}

sub body {
    'yoyoyoy'
}

1;
