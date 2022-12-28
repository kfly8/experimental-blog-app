package Blog::Web::Controller::Entry;
use v5.36;
use utf8;

use Mojo::Base 'Mojolicious::Controller';
use Blog::Web::Sugar;

use constant EntryComment => {
    id => JSON_TYPE_STRING,
    body => JSON_TYPE_STRING,
};

use constant Entry => {
    id      => JSON_TYPE_STRING,
    title   => JSON_TYPE_STRING,
    summary => JSON_TYPE_STRING,
};

use constant EntryDetail => {
    id       => JSON_TYPE_STRING,
    title    => JSON_TYPE_STRING,
    body     => JSON_TYPE_STRING,
    comments => json_type_arrayof(EntryComment),
};

use Blog::Entity::Entry;
use Blog::Command::PostEntry;
use Blog::Command::PostEntryComment;

sub show($c) {
    my $entity = Blog::Entity::Entry->new;
    my $entry = $entity->fetch_by_id($c->param('entry_id'));
    unless ($entry) {
        return $c->reply->not_found
    }

    $c->render(
        status => HTTP_OK,
        data => $c->json_encode({ entry => $entry }, { entry => EntryDetail })
    );
}

sub list($c) {
    my $entity = Blog::Entity::Entry->new;
    my $entries = $entity->select_all({});

    $c->render(
        status => HTTP_OK,
        data => $c->json_encode(
            { entries => $entries },
            { entries => json_type_arrayof(Entry) }
        )
    );
}

sub post($c) {
    try {
        Blog::Command::PostEntry->run(
            title => $c->req->json->{title},
            body => $c->req->json->{body},
        );
    }
    catch ($e) {
        $c->log->error($e);
        return $c->reply->exception('some error');
    }

    $c->rendered(HTTP_CREATED);
}

sub post_comment($c) {
    try {
        Blog::Command::PostEntryComment->run(
            entry_id => $c->param('entry_id'),
            body => $c->req->json->{body},
        );
    }
    catch ($e) {
        $c->log->error($e);
        return $c->reply->exception('some error');
    }

    $c->rendered(HTTP_CREATED);
}

1;
