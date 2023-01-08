package Blog::GraphQL::QueryResolver::Entries;
use v5.36;
use utf8;
use Moo;
with 'Blog::GraphQL::QueryResolverRole';

use Blog::Unit::Entry::EntryFetcher ();

sub main ($self, $args, $context, $info) {
    my $fetcher = Blog::Unit::Entry::EntryFetcher->entity;
    my $entries = $fetcher->select_all({});

    return $entries;
}

1;
