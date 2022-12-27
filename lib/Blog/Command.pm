package Blog::Command;
use v5.36;
use Moo;

sub main { die 'implements required' }

sub run($class, %args) {
    my $self = $class->new(%args);
    return $self->main;
}

1;
