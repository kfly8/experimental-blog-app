package Blog::GraphQL::Query;
use v5.36;
use utf8;

use Class::Load qw(is_class_loaded);

use Blog::GraphQL::Resolver::GreateEntry;

sub resolver($resolver_class) {
    unless (is_class_loaded($resolver_class)) {
        die "need to use $resolver_class";
    }
    unless ($resolver_class->can('resolve')) {
        die "need to implements resolve function in $resolver_class";
    }

    $resolver_class->can('resolve');
}

use constant root => {
    greatEntry => resolver('Blog::GraphQL::Resolver::GreateEntry'),
};


1;
