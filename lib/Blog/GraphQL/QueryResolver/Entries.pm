package Blog::GraphQL::QueryResolver::Entries;
use v5.36;
use utf8;
use Moo;
with 'Blog::GraphQL::QueryResolverRole';

use Blog::Unit::Entry::EntryFetcher;

sub main($self, $args, $context, $info) {
    my $entry_fetcher = Blog::Unit::Entry::EntryFetcher->new;
    my $entries = $entry_fetcher->select_all({});

    return $entries;
}

1;
