package Blog::Util;
use v5.36;
use Exporter 'import';

use Data::UUID;

our @EXPORT_OK = qw(generate_uuid);

sub generate_uuid() {
    state $ug = Data::UUID->new;
    $ug->create_str;
}

1;
