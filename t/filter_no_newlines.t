#!perl -w
use strict;
use Test::More tests => 1;
BEGIN {
    unshift @INC, 't/lib/';
}

require Filter::Simple;

# Create a very simple filter
my $filter = Filter::Simple::gen_std_filter_for('code', sub {});

my $input = join "\n", "line1", "line2", "line3";

$_ = $input;
$filter->();
my $output = $_;
is $output, $input, "Our identity filter also keeps a line without a newline at the end";
