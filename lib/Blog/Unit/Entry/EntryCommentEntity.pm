package Blog::Unit::Entry::EntryCommentEntity;
use v5.36;
use utf8;

use Moo;

has id       => (is => 'ro');
has entry_id => (is => 'ro');
has body     => (is => 'ro');

1;
