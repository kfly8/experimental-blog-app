package Blog::Web::Controller::Root;
use v5.36;
use utf8;

use Mojo::Base 'Mojolicious::Controller';
use Blog::Web::Sugar;

sub welcome ($c) {
    $c->render(
        status => HTTP_OK,
        data   => $c->json_encode({ message => "HELLO 世界" }, { message => JSON_TYPE_STRING })
    );
}

1;
