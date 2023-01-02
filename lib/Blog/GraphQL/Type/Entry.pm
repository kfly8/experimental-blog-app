package Blog::GraphQL::Type::Entry;
use v5.36;
use utf8;
use Moo;
extends qw(Blog::GraphQL::TypeObject);

use Blog::GraphQL::Type::EntryComment;

sub id($self, @rest) {
    $self->object->id;
}

sub title($self, @rest) {
    $self->object->title;
}

sub body($self, @rest) {
    $self->object->body;
}

sub comments($self, @rest) {
    my $comments = $self->object->comments;
    my @data;
    while (my $comment = $comments->next) {
        push @data => Blog::GraphQL::Type::EntryComment->new(object => $comment)
    }
    return \@data;
}

1;
