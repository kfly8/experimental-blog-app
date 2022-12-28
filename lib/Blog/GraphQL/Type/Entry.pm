package Blog::GraphQL::Type::Entry;
use v5.36;
use utf8;
use Moo;
extends qw(Blog::GraphQL::Type);

use Blog::GraphQL::Type::EntryComment;

sub id {
    'dummy EntryComment id'
}

sub title {
    'waiwai'
}

sub body {
    'yoyoyoy'
}

sub comments {
    [
        Blog::GraphQL::Type::EntryComment->new,
    ]
}

1;
