package Blog::GraphQL::Type::Entry;
use v5.36;
use utf8;
use Moo;
extends qw(Blog::GraphQL::TypeObject);

use Blog::Unit::Entry::EntryCommentFetcher ();

sub id ($self, @) {
    $self->object->id;
}

sub title ($self, @) {
    $self->object->title;
}

sub body ($self, @) {
    $self->object->body;
}

sub comments ($self, $args, $context, @) {
    my $loader = $self->data_loader($context, Blog::Unit::Entry::EntryCommentFetcher->can('batch_comments'));
    $loader->load($self->object->id);
}

1;
