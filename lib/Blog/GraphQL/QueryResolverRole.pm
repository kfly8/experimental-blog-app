package Blog::GraphQL::QueryResolverRole;
use v5.36;
use utf8;
use Moo::Role;

use Iterator::Simple qw(iter);
use Class::Load qw(try_load_class);
use Types::Common -types;
use namespace::autoclean;

requires 'main';

has type => (
    is => 'ro',
    isa => InstanceOf['GraphQL::Type']
);

has object_class => (
    is => 'lazy',
    default => sub ($self) {
        my $object_class = 'Blog::GraphQL::Type::' . $self->type->name;
        unless (try_load_class($object_class)) {
            die "Could not load object class: $object_class"
        }
        return $object_class;
    },
);

sub resolver($self) {

    # TODO pager list, single typeなどの結果の場合のconverter
    my $convert_method = $self->type isa GraphQL::Type::List ? 'convert_list'
                       : die 'unknown graphql schema type ' . $self->type;

    return sub {
        my ($args, $context, $info) = @_;
        my $result = $self->main($args, $context, $info);
        return $self->$convert_method($result);
    }
}


sub convert_list($self, $list) {
    my @data;
    my $iter = iter($list);
    while (my $object = $iter->next) {
        push @data => $self->object_class->new(
            object => $object
        );
    }
    return \@data;
}


1;
