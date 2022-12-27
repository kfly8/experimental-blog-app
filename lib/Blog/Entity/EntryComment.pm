package Blog::Entity::EntryComment;
use v5.36;
use utf8;

use Moo;
use Types::Common -types;

extends 'Blog::Entity';
with qw(
    Blog::Role::SQLiteHandle
    Blog::Role::TableInfo
    Blog::Role::TableFetch
    Blog::Role::TableSave
);

sub table_name { 'entry_comment' }

has 'id' => (is => 'ro');
has 'entry_id' => (is => 'ro');
has 'body' => (is => 'ro');

1;
