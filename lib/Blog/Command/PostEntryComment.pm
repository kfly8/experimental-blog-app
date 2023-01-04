# 記事コメントの投稿
package Blog::Command::PostEntryComment;
use v5.36;
use utf8;

use Moo;
use Types::Common -types;

use Blog::Util qw(generate_uuid);
use Blog::Unit::Entry::EntryCommentEntity;
use Blog::Unit::Entry::EntryCommentSaver;

with 'Blog::CommandRole';

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
    my $entry_comment = Blog::Unit::Entry::EntryCommentEntity->new(
        id       => $self->id,
        entry_id => $self->entry_id,
        body     => $self->body,
    );

    my $saver = Blog::Unit::Entry::EntryCommentSaver->new;
    $saver->insert($entry_comment);

    $entry_comment;
}

1;
