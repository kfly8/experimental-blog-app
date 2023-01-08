package Blog::UnitRole::TableFetch;
use v5.36;
use Moo::Role;

$DBIx::Sunny::SKIP_CALLER_REGEX = qr!$DBIx::Sunny::SKIP_CALLER_REGEX|^Blog::UnitRole::TableFetch\b!;

use Carp             qw(croak);
use Class::Load      qw(try_load_class);
use Iterator::Simple qw(imap iter);
use Scalar::Util     qw(blessed);
use namespace::autoclean;

requires qw(dbh query_builder);
requires qw(table_name);

has build_row => (
    is      => 'rw',
    default => sub ($self) {
        sub ($self, $row) { $row }
    }
);

has build_collection => (
    is      => 'rw',
    default => sub ($self) {
        sub ($self, $rows) {
            imap { $self->build_row->($self, $_) } $rows;
        }
    }
);

sub fetch ($self, $where, $opt = {}, $fields = ['*']) {
    unless (ref $self) {
        return $self->new->fetch($where, $opt, $fields);
    }

    my ($sql, @binds) = $self->query_builder->select($self->table_name, $fields, $where, $opt);

    my $row = $self->dbh->select_row($sql, @binds);

    return $self->build_row->($self, $row);
}

sub fetch_by_id ($self, $id, $opt = {}, $fields = ['*']) {
    my $where = { id => $id };
    return $self->fetch($where, $opt, $fields);
}

sub select_all ($self, $where, $opt = {}, $fields = ['*']) {
    unless (ref $self) {
        return $self->new->select_all($where, $opt, $fields);
    }

    my ($sql, @binds) = $self->query_builder->select($self->table_name, $fields, $where, $opt);

    my $rows = $self->dbh->select_all($sql, @binds);

    return $self->build_collection->($self, $rows);
}

# XXX: 必要?
sub count ($self, $where, $opt = {}, $count_column = undef) {
    unless (ref $self) {
        return $self->new->count($where, $opt, $count_column);
    }

    $count_column //= \'COUNT(*)';

    my ($sql, @binds) = $self->query_builder->select($self->table_name, [$count_column], $where, $opt);

    my $count = $self->dbh->select_one($sql, @binds);
}

sub entity ($class) {
    $class->new(
        build_row => sub ($self, $row) {
            unless ($row) {
                return $row;
            }

            unless ($self->can('entity_class')) {
                croak 'implement entity_class method';
            }

            unless (try_load_class($self->entity_class)) {
                croak 'implement entity class';
            }

            return $self->entity_class->new($row);
        }
    );
}

sub graphql ($class) {
    $class->new(
        build_row => sub ($self, $row) {
            unless ($self->can('graphql_class')) {
                croak 'implement graphql_class method';
            }

            unless (try_load_class($self->graphql_class)) {
                croak 'implement graphql class';
            }

            my $entity = $self->entity_class->new($row);
            return $self->graphql_class->new(object => $entity);
        }
    );
}

sub batch_values ($self, $key, $key_values) {
    my $where  = { $key => $key_values };
    my $result = $self->select_all($where);

    my $iter = iter($result);

    my %map;

    while (my $row = $iter->next) {
        my $key_value = $row->object->$key;
        push $map{$key_value}->@* => $row;
    }

    map { $map{$_} // [] } $key_values->@*;
}

1;
