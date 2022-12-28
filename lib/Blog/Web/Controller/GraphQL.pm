package Blog::Web::Controller::GraphQL;
use v5.36;
use utf8;

use Mojo::Base 'Mojolicious::Controller';
use Blog::Web::Sugar;

use Mojo::Home;

use GraphQL::Schema;
use GraphQL::Language::Parser ();
use GraphQL::Execution ();

sub endpoint($c) {
    my $file = Mojo::Home->new('schema.graphql');
    my $schema = GraphQL::Schema->from_doc($file->slurp);

    my $query = $c->req->json->{query};

    # TODO: たたかれるqueryを事前にastにしてホワイトリストしたい。安全とパフォーマンスのため。
    my $parsed_query = GraphQL::Language::Parser::parse($query);

    my $root_value = {
        entry => sub {
            {
                title => 'waiwai',
                body => 'yoyoyo'
            }
        },
    };

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

1;
