package Blog::GraphQL::Type::EntryComment;
use v5.36;
use utf8;
use Moo;
extends qw(Blog::GraphQL::TypeObject);

sub id ($self, @) {
    $self->object->id;
}

sub body ($self, @) {
    $self->object->body;
}

1;
