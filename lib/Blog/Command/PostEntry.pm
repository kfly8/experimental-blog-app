# 記事の投稿
package Blog::Command::PostEntry;
use v5.36;
use utf8;

use Moo;
use Types::Common -types;
use Blog::Util qw(generate_uuid);
use namespace::autoclean;

use Blog::Entity::Entry;

extends 'Blog::Command';

has id => (
    is => 'ro',
    default => sub { generate_uuid }
);

has title => (
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
    my $entry = Blog::Entity::Entry->new(
        id    => $self->id,
        title => $self->title,
        body  => $self->body,
    );

    $entry->insert;
    $entry;
}

1;
