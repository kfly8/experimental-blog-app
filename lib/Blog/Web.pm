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

    $r->get('/entry/:id')->to('Entry#show');
    $r->post('/entry')->to('Entry#post');
}

1;
