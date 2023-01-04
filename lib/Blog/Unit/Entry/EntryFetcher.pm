package Blog::Unit::Entry::EntryFetcher;
use v5.36;
use utf8;

use Moo;

with qw(
    Blog::UnitRole::SQLiteHandle
    Blog::UnitRole::TableFetch
);

sub table_name { 'entry' }
sub entity_class { 'Blog::Unit::Entry::EntryEntity' }
sub graphql_class { 'Blog::GraphQL::Type::Entry' }

1;
