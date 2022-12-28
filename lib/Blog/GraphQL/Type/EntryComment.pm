package Blog::GraphQL::Type::EntryComment;
use v5.36;
use utf8;
use Moo;
extends qw(Blog::GraphQL::Type);

sub id {
    'dummy EntryComment id'
}

sub body {
    'comment'
}

1;
