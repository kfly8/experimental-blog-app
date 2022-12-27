package Blog::Entity::Entry;
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

sub table_name { 'entry' }

has 'id' => (is => 'ro');
has 'title' => (is => 'ro');
has 'body' => (is => 'ro');

has comments => (
    is => 'rw',
    isa => ArrayRef[InstanceOf['Blog::Domain::EntryComment']]
);

sub summary($self) {
    substr($self->body, 0, 10);
}

1;
