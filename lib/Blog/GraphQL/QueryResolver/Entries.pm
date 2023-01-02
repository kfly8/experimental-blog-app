package Blog::GraphQL::QueryResolver::Entries;
use v5.36;
use utf8;
use Moo;
with 'Blog::GraphQL::QueryResolverRole';

use Blog::Entity::Entry;

sub main($self, $args, $context, $info) {
    my $entity = Blog::Entity::Entry->new;
    my $entries = $entity->select_all({});

    return $entries;
}

1;
