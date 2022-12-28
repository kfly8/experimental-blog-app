package Blog::GraphQL::Type::Payload::GreatEntry;
use v5.36;
use utf8;
use Moo;
extends qw(Blog::GraphQL::Type);

use Types::Common -types;

use Blog::GraphQL::Type::Entry;

sub point {
    my ($self, $args, $context, $info) = @_;

    'あああああああああ'
}

sub entry {
    Blog::GraphQL::Type::Entry->new;
}

1;
