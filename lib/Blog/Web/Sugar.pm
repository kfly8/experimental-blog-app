package Blog::Web::Sugar;
use v5.36;

use Import::Into;

sub import {
    my $target = caller;

    HTTP::Status->import::into($target, ':constants');
    Cpanel::JSON::XS::Type->import::into($target);
    experimental->import::into($target, 'try');
}

1;
