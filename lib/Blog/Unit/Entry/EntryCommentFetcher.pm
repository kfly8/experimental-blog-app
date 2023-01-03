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

1;
