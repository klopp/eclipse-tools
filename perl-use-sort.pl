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
const my %EXCLUDE => (
    vars     => undef,
    self     => undef,
    threads  => undef,
    forks    => undef,
    base     => undef,
    parent   => undef,
    open     => undef,
    utf8     => undef,
    warnings => undef,
    strict   => undef,
    Modern   => undef,
    version  => undef,
    DDP      => undef,
);

# ------------------------------------------------------------------------------
our $VERSION = 'v1.0';

# ------------------------------------------------------------------------------
$ARGV[0]
    or Carp::croak sprintf "\n%s %s\n\nUsage: %s {file}\n", basename($PROGRAM_NAME), $VERSION, basename($PROGRAM_NAME);
my @lines = path( $ARGV[0] )->lines;
my @use;

for (@lines) {
    if ( !/^use\s+(\w+).*;$/sm ) {
        print $_ for sort { lc $a cmp lc $b } @use;
        undef @use;
        print $_;
    }
    elsif ( exists $EXCLUDE{$1} ) {
        print $_;
    }
    else {
        push @use, $_;
    }
}

exit 0;

# ------------------------------------------------------------------------------
__END__
