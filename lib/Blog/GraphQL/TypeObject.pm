package Blog::GraphQL::TypeObject;
use v5.36;
use utf8;
use Moo;

use DataLoader;
use Mojo::Promise;

has object => (
    is => 'ro',
    required => 1
);

sub data_loader($self, $context, $key, $batch_code) {
    $context->{__data_loaders}{ref $self}{$key} //= do {
        DataLoader->new(sub (@batch_args) {
            my $promise = Mojo::Promise->new(sub ($resolve, $reject) {
                my @values = $batch_code->(@batch_args);
                $resolve->(@values);
            });
            return $promise;
        })
    };
}


1;
