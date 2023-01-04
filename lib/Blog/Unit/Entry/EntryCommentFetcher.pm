package Blog::Unit::Entry::EntryCommentFetcher;
use v5.36;
use utf8;

use Moo;

with qw(
    Blog::UnitRole::SQLiteHandle
    Blog::UnitRole::TableFetch
);

sub table_name { 'entry_comment' }
sub entity_class { 'Blog::Unit::Entry::EntryCommentEntity' }
sub graphql_class { 'Blog::GraphQL::Type::EntryComment' }


sub batch_comments(@entry_ids) {
    my $fetcher = __PACKAGE__->graphql;
    $fetcher->batch_values(entry_id => \@entry_ids)
}

1;
