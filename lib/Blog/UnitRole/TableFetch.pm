package Blog::UnitRole::TableFetch;
use v5.36;
use Moo::Role;

$DBIx::Sunny::SKIP_CALLER_REGEX = qr!$DBIx::Sunny::SKIP_CALLER_REGEX|^Blog::UnitRole::TableFetch\b!;

requires qw(dbh query_builder);
requires qw(table_name entity_class);

use Iterator::Simple qw(imap);

=head2

fetchの結果を圧縮するかいなか

  $entity = Blog::Entity::SomeTable;

  $entity->suppress_result(1);
  my $result = $entity->fetch_by_id(123);
  $result; # isa HashRef

=cut
has suppress_result => (
    is => 'rw',
    default => !!0,
);

sub fetch($self, $where, $opt = {}, $fields = ['*']) {
    my ($sql, @binds) = $self->query_builder->select(
        $self->table_name, $fields, $where, $opt
    );

    my $row = $self->dbh->select_row($sql, @binds);

    if ($row && !$self->suppress_result) {
        return $self->entity_class->new($row);
    }
    else {
        return $row;
    }
}

sub fetch_by_id($self, $id, $opt = {}, $fields = ['*']) {
    my $where = { id => $id };
    return $self->fetch($where, $opt, $fields);
}

sub select_all($self, $where, $opt = {}, $fields = ['*']) {
    my ($sql, @binds) = $self->query_builder->select(
        $self->table_name, $fields, $where, $opt
    );

    my $rows = $self->dbh->select_all($sql, @binds);

    if ($self->suppress_result) {
        return $rows;
    }
    else {
        return imap { $self->entity_class->new($_) } $rows
    }
}

sub count($self, $where, $opt = {}, $count_column = [\'COUNT(*)']) {
    my ($sql, @binds) = $self->query_builder->select(
        $self->table_name, [$count_column], $where, $opt
    );

    my $count = $self->dbh->select_one($sql, @binds);
}

1;
