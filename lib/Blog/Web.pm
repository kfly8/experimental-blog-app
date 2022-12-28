package Blog::Web;
use v5.36;
use utf8;

use Mojo::Base 'Mojolicious';

sub startup($self) {
    $self->app->exception_format('json');
    $self->app->renderer->default_format('json');
    $self->app->plugin('Blog::Web::Plugin::JSON');

    my $r = $self->routes;
    $r->namespaces(['Blog::Web::Controller']);

    $r->get('/')->to('Root#welcome');

    $r->get('/entry/:entry_id')->to('Entry#show');
    $r->post('/entry')->to('Entry#post');
    $r->post('/entry/:entry_id/comment')->to('Entry#post_comment');

    $r->post('/graphql')->to('GraphQL#endpoint');

    if ($self->mode eq 'development') {
        $r->get('/graphiql')->to('GraphQL#graphiql');
    }
}

1;
