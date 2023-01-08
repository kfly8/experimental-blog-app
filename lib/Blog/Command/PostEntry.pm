# 記事の投稿
package Blog::Command::PostEntry;
use v5.36;
use utf8;

use Moo;
use Types::Common qw( Str );

use Blog::Util qw( generate_uuid );
use Blog::Unit::Entry::EntryEntity ();
use Blog::Unit::Entry::EntrySaver ();

with 'Blog::CommandRole';

has id => (
    is      => 'ro',
    default => sub { generate_uuid }
);

has title => (
    is       => 'rw',
    isa      => Str,
    required => 1,
);

has body => (
    is       => 'rw',
    isa      => Str,
    required => 1,
);

sub main ($self) {
    my $entry = Blog::Unit::Entry::EntryEntity->new(
        id    => $self->id,
        title => $self->title,
        body  => $self->body,
    );

    my $saver = Blog::Unit::Entry::EntrySaver->new;
    $saver->insert($entry);

    $entry;
}

1;
