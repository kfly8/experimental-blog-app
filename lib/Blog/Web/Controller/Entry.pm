package Blog::Web::Controller::Entry;
use v5.36;
use utf8;

use Mojo::Base 'Mojolicious::Controller';
use Blog::Web::Sugar;

use constant EntryComment => {
    id => JSON_TYPE_STRING,
    body => JSON_TYPE_STRING,
    entry_id => undef, #XXX ignoreしたい
};

use constant Entry => {
    id            => JSON_TYPE_STRING,
    title         => JSON_TYPE_STRING,
    summary       => JSON_TYPE_STRING,
    comment_count => JSON_TYPE_INT,
};

use constant EntryDetail => {
    id       => JSON_TYPE_STRING,
    title    => JSON_TYPE_STRING,
    body     => JSON_TYPE_STRING,
    comments => json_type_arrayof(EntryComment),
};

use Blog::Unit::Entry::EntryFetcher;
use Blog::Command::PostEntry;
use Blog::Command::PostEntryComment;

sub show($c) {
    my $fetcher = Blog::Unit::Entry::EntryFetcher->entity;
    my $entry = $fetcher->fetch_by_id($c->param('entry_id'));
    unless ($entry) {
        return $c->reply->not_found
    }

    $c->render(
        status => HTTP_OK,
        data => $c->json_encode({ entry => $entry }, { entry => EntryDetail })
    );
}

sub list($c) {
    my $fetcher = Blog::Unit::Entry::EntryFetcher->entity;
    my $entries = $fetcher->entity->select_all({});

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
