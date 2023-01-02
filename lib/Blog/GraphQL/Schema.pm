package Blog::GraphQL::Schema;
use v5.36;
use utf8;

use Mojo::Home;
use GraphQL::Schema;

my $file = Mojo::Home->new('graphql/schema.graphql');
my $schema = GraphQL::Schema->from_doc($file->slurp);

sub schema { $schema }

1;

