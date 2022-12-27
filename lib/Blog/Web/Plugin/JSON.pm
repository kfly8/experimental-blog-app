package Blog::Web::Plugin::JSON;
use v5.36;
use utf8;

use Mojo::Base 'Mojolicious::Plugin';

use Cpanel::JSON::XS;
use Scalar::Util ();
use JSON::UnblessObject ();
use Encode ();

my $JSON_SELIALIZER = Cpanel::JSON::XS->new->ascii(0);

sub register {
    my ($self, $app) = @_;

    $app->helper(json_encode => sub {
        my ($c, $data, $json_spec) = @_;

        my $json = unblessed_data($data, $json_spec);
        my $encoded_json = $JSON_SELIALIZER->encode($json, $json_spec);
        Encode::encode($c->app->renderer->encoding, $encoded_json);
    });
}

sub unblessed_data {
    my ($data, $json_spec) = @_;

    if (Scalar::Util::blessed($data)) {
        return JSON::UnblessObject::unbless_object($data, $json_spec)
    }
    elsif (ref $data && ref $data eq 'HASH') {
        my %h;
        for my $key (keys $data->%*) {
            my $next_data = $data->{$key};
            my $next_spec = $json_spec->{$key};
            $h{$key} = unblessed_data($next_data, $next_spec);
        }
        return \%h
    }
    else {
        return $data
    }
}

1;
