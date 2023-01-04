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

use DataLoader;
use Mojo::Promise;
use Blog::Unit::Entry::EntryCommentFetcher;

# FIXME context単位でloaderを保持する
my $loader = DataLoader->new(sub (@entry_ids) {
    my $promise = Mojo::Promise->new(sub ($resolve, $reject) {
        my $entry_comment_fetcher = Blog::Unit::Entry::EntryCommentFetcher->new;
        my $comments = $entry_comment_fetcher->select_all({ entry_id => \@entry_ids });
        my %map;
        while (my $comment = $comments->next) {
            push $map{$comment->{entry_id}}->@* => Blog::GraphQL::Type::EntryComment->new(
                object => $comment
            );
        }
        my @values = map { $map{$_} // [] } @entry_ids;
        $resolve->(@values);
    });
    return $promise
});

sub comments($self, @rest) {
    $loader->load($self->object->id);
}

1;
