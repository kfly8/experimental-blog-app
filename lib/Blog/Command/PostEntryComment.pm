# 記事コメントの投稿
package Blog::Command::PostEntryComment;
use v5.36;
use utf8;

use Moo;
use Types::Common -types;
use Blog::Util qw(generate_uuid);
use namespace::autoclean;

use Blog::Entity::EntryComment;

extends 'Blog::Command';

has id => (
    is => 'ro',
    default => sub { generate_uuid }
);

has entry_id => (
    is => 'rw',
    isa => Str,
    required => 1,
);

has body => (
    is => 'rw',
    isa => Str,
    required => 1,
);

sub main($self) {
    my $entry_comment = Blog::Entity::EntryComment->new(
        id       => $self->id,
        entry_id => $self->entry_id,
        body     => $self->body,
    );

    $entry_comment->insert;
    $entry_comment;
}

1;
