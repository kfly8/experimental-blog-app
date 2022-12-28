#!/usr/bin/env perl
use v5.36;
use lib 'lib';

use Blog::Schema;

print Blog::Schema->output;
