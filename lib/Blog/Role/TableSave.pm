package Blog::Role::TableSave;
use v5.36;
use Moo::Role;

requires qw(dbh query_builder);
requires qw(table_name table_field_names);

sub insert($self, $opt = {}) {
    my $values = {
        map { $_ => $self->$_ } $self->table_field_names->@*
    };

    my ($sql, @binds) = $self->query_builder->insert(
        $self->table_name,
        $values,
        $opt,
    );

    $self->dbh->query($sql, @binds);
}

1;
