package Blog::GraphQL::Query;
use v5.36;
use utf8;

use Module::Find qw(usesub);

usesub Blog::GraphQL::Resolver;

sub root {
    return {
        entries => Blog::GraphQL::Resolver::Entries->can('resolve') // die,
    }
};


1;
