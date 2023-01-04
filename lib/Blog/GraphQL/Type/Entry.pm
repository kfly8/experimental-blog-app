package Blog::GraphQL::Type::Entry;
use v5.36;
use utf8;
use Moo;
extends qw(Blog::GraphQL::TypeObject);

use Blog::GraphQL::Type::EntryComment;
use Blog::Unit::Entry::EntryCommentFetcher;

sub id($self, @) {
    $self->object->id;
}

sub title($self, @) {
    $self->object->title;
}

sub body($self, @) {
    $self->object->body;
}

sub comments($self, $args, $context, @) {
    my $loader = $self->data_loader($context, comments => \&batch_comments);
    $loader->load($self->object->id);
}

sub batch_comments(@entry_ids) {
    my $entry_comment_fetcher = Blog::Unit::Entry::EntryCommentFetcher->new;
    my $comments = $entry_comment_fetcher->select_all({ entry_id => \@entry_ids });

    my %map;
    while (my $comment = $comments->next) {
        push $map{$comment->{entry_id}}->@* => Blog::GraphQL::Type::EntryComment->new(object => $comment);
    }
    my @values = map { $map{$_} // [] } @entry_ids;
    return @values;
}

1;
