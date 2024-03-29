requires 'perl', '5.036';

# Class Builder & Type Systems
requires 'Moo';
requires 'Type::Tiny';

# Web Application
requires 'Mojolicious';
requires 'HTTP::Status';
requires 'GraphQL';
requires 'Cpanel::JSON::XS';
requires 'JSON::UnblessObject';
requires 'Encode';

# Database
requires 'DBIx::Sunny';
requires 'DBIx::Handler';
requires 'DBD::SQLite';
requires 'SQL::Maker';
requires 'DBIx::Schema::DSL';

# Utility
requires 'constant';
requires 'experimental';
requires 'namespace::autoclean';
requires 'Carp';
requires 'Iterator::Simple';
requires 'String::CamelCase';
requires 'Class::Load';
requires 'Import::Into';
requires 'Module::Find';

# Mojoに依存しない実装が良いと思うけど、試しにいれてみる
requires 'DataLoader';

on 'develop' => sub {
    requires 'Carmel';
    requires 'Perl::Critic';
    requires 'Perl::Tidy';
    requires 'App::perlimports';
    requires 'DBIx::QueryLog';
    requires 'Data::Printer';
};

on 'test' => sub {
    requires 'Test2::V0';
};
