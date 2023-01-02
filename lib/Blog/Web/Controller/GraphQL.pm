package Blog::Web::Controller::GraphQL;
use v5.36;
use utf8;

use Mojo::Base 'Mojolicious::Controller';
use Blog::Web::Sugar;

use Mojo::Home;

use Blog::GraphQL::Schema;
use GraphQL::Language::Parser ();
use GraphQL::Execution ();

use Blog::GraphQL::Query;

sub endpoint($c) {
    my $schema = Blog::GraphQL::Schema->schema;

    my $query = $c->req->json->{query};

    # TODO: たたかれるqueryを事前にastにしてホワイトリストにいれておきたい。安全とパフォーマンスのため。
    my $parsed_query = GraphQL::Language::Parser::parse($query);

    # TODO: queryだけでなく mutationも加える
    my $root_value = Blog::GraphQL::Query->resolver;

    my $context_value = { current_blog => 'waiwai.blog' };
    my $variable_values = $c->req->json->{variables};
    my $operation_name = $c->req->json->{operationName};
    my $field_resolver = undef;
    my $promise_code = undef;

    my $result = GraphQL::Execution::execute(
      $schema,
      $parsed_query,
      $root_value,
      $context_value,
      $variable_values,
      $operation_name,
      $field_resolver,
      $promise_code,
    );

    $c->render(
        status => HTTP_OK,
        json => $result,
    );
}

sub graphiql($c) {
    my $file = Mojo::Home->new('graphql/graphiql.html');
    $c->render(
        format => 'html',
        data => $file->slurp,
    );
}

1;
