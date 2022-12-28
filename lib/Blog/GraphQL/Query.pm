package Blog::GraphQL::Query;
use v5.36;
use utf8;

use Module::Find qw(usesub);

usesub Blog::GraphQL::Resolver;

sub root {
    return {
        greatEntry => Blog::GraphQL::Resolver::GreateEntry->can('resolve') // die,
    }
};


1;
