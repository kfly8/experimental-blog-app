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

use Blog::Entity::EntryComment;

sub table_name { 'entry' }

has 'id' => (is => 'ro');
has 'title' => (is => 'ro');
has 'body' => (is => 'ro');

has comment_entity => (
    is => 'lazy',
    builder => sub ($self) {
        Blog::Entity::EntryComment->new;
    }
);

has comments => (
    is => 'lazy',
    builder => sub ($self) {
        my $comments = $self->comment_entity->select_all({ entry_id => $self->id});
    }
);

sub summary($self) {
    substr($self->body, 0, 10);
}

1;
