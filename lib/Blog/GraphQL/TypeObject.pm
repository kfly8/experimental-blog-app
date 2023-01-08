package Blog::GraphQL::TypeObject;
use v5.36;
use utf8;
use Moo;

use DataLoader;
use Mojo::Promise;
use Carp qw(croak);
use namespace::autoclean;

use Blog::GraphQL::Schema;

sub BUILD {
    my ($self, $args) = @_;

    for my $key (keys $self->graphql_type->fields->%*) {
        unless ($self->can($key)) {
            croak sprintf 'implements `%s` method at %s', $key, ref $self;
        }
    }
}

has object => (
    is       => 'ro',
    required => 1
);

sub graphql_type ($invocant) {
    my $class       = ref $invocant || $invocant;
    my ($type_name) = $class =~ m!([^:]+)$!g;
    my $type        = Blog::GraphQL::Schema->schema->name2type->{$type_name};

    unless ($type) {
        croak "cannot find type: $type_name";
    }
    return $type;
}

sub data_loader ($self, $context, $batch_code) {
    my $subroutine = (caller 1)[3];

    $context->{__data_loaders}{$subroutine} //= do {
        DataLoader->new(
            sub (@batch_args) {
                my $promise = Mojo::Promise->new(
                    sub ($resolve, $reject) {
                        my @values = $batch_code->(@batch_args);
                        $resolve->(@values);
                    }
                );
                return $promise;
            }
        );
    };
}

1;
