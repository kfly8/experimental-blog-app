package Blog::CommandRole;
use v5.36;
use Moo::Role;

requires 'main';

sub run($class, %args) {
    my $self = $class->new(%args);
    return $self->main;
}

1;
