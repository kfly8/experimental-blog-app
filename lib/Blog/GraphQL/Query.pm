package Blog::GraphQL::Query;
use v5.36;
use utf8;

use String::CamelCase qw(camelize);
use Class::Load       qw(try_load_class);
use Carp              qw(croak);

use Blog::GraphQL::Schema;

sub resolver ($class) {
    my $result = {};

    my $fields = $class->schema_query->fields;

    for my $key (keys $fields->%*) {
        my $resolver_class = $class->resolver_class($key);
        my $schema_type    = $class->schema_type($key);

        $result->{$key} = $resolver_class->new(graphql_type => $schema_type)->resolver;
    }

    return $result;
}

sub resolver_class ($class, $field_name) {
    my $resolver_class = 'Blog::GraphQL::QueryResolver::' . camelize($field_name);

    unless (try_load_class($resolver_class)) {
        croak "Could not load `$field_name` resolver class: $resolver_class";
    }
    return $resolver_class;
}

sub schema_query ($class) {
    Blog::GraphQL::Schema->schema->query;
}

sub schema_type ($class, $field_name) {
    $class->schema_query->fields->{$field_name}->{type};
}

1;
