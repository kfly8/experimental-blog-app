package Blog::Unit::Entry::EntrySaver;
use v5.36;
use utf8;

use Moo;

with qw(
    Blog::UnitRole::SQLiteHandle
    Blog::UnitRole::TableInfo
    Blog::UnitRole::TableSave
);

sub table_name { 'entry' }

1;
