#!/usr/bin/perl

# ------------------------------------------------------------------------------
use strict;
use warnings;
use utf8::all;
use open qw/:std :utf8/;

# ------------------------------------------------------------------------------
use Const::Fast;
use English qw/-no_match_vars/;
use File::Basename qw/basename/;
use Path::Tiny;

use DDP;

# ------------------------------------------------------------------------------
our $VERSION = 'v1.0';

# ------------------------------------------------------------------------------
$ARGV[0]
    or Carp::croak sprintf "\n%s %s\n\nUsage: %s {file}\n", basename($PROGRAM_NAME), $VERSION, basename($PROGRAM_NAME);
my @lines = path( $ARGV[0] )->lines;
my @include;

for (@lines) {
    if ( !/^#include\s+["<]([\w.]+)[">]/sm ) {
        print $_ for sort { lc $a cmp lc $b } @include;
        undef @include;
        print $_;
    }
    else {
        push @include, $_;
    }
}

exit 0;

# ------------------------------------------------------------------------------
__END__
