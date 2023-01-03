package Blog::UnitRole::TableInfo;
use v5.36;
use Moo::Role;
use Blog::Schema;

requires 'table_name';

has table_info => (
    is => 'lazy',
    builder => sub($self) {
        # isa SQL::Translator::Schema::Table
        Blog::Schema->context->schema->get_table($self->table_name);
    }
);

has table_field_names => (
    is => 'lazy',
    builder => sub($self) {
        $self->table_info->field_names;
    }
);

1;
