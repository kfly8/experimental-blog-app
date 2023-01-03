package Blog::UnitRole::SQLiteHandle;
use v5.36;
use Moo::Role;

use DBIx::Sunny;
use SQL::Maker;

has dbh => (
    is => 'ro',
    default => sub($self) {
        my $user     = $ENV{BLOG_SQLITE_USER}       || '';
        my $password = $ENV{BLOG_SQLITE_PASSWORD}   || '';
        my $dbname   = $ENV{BLOG_SQLITE_NAME}       || 'db/blog.db';

        my $dsn = "dbi:SQLite:database=$dbname";
        my $dbh = DBIx::Sunny->connect($dsn, $user, $password, {});
        return $dbh;
    }
);

has query_builder => (
    is => 'ro',
    default => sub ($self) {
        SQL::Maker->new(driver => 'SQLite');
    }
);

1;
