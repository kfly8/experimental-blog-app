package Blog::Schema;
use v5.36;
use DBIx::Schema::DSL;

database 'SQLite';
create_database 'blog';
default_not_null();

create_table 'entry' => columns {
    string 'id', primary_key;
    text 'title';
    text 'body';

    has_many 'entry_comment';
};

create_table 'entry_comment' => columns {
    string 'id', primary_key;
    string 'entry_id';
    text 'body';

    belongs_to 'entry';
};

1;
