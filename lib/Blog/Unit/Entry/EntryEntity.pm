package Blog::Unit::Entry::EntryEntity;
use v5.36;
use utf8;

use Moo;
use Class::Load qw(load_class);
use namespace::autoclean;

has id    => (is => 'ro');
has title => (is => 'ro');
has body  => (is => 'ro');

has comment_fetcher => (
    is      => 'lazy',
    builder => sub ($self) {
        load_class('Blog::Unit::Entry::EntryCommentFetcher')->new;
    }
);

# TODO: N+1対応
has comment_count => (
    is      => 'lazy',
    builder => sub ($self) {
        my $count = $self->comment_fetcher->count({ entry_id => $self->id });
    }
);

# TODO: N+1対応
sub comments ($self) {
    my $comments = $self->comment_fetcher->select_all({ entry_id => $self->id });
}

sub summary ($self) {
    substr($self->body, 0, 10);
}

1;
