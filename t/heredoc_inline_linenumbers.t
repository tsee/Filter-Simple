#!perl -w
use strict;
use Test::More tests => 6;
BEGIN {
    unshift @INC, 't/lib/';
}

use Filter::Simple::null;

diag $Filter::Simple::VERSION;

        my $decl = <<'XS';
foo
XS
        my $decl2 = <<'XS'
bar
XS
;
        my @decl3 = (<<'XS', <<'XS');
nananana
XS
batman
XS

# Especially devious, to trick simple-minded parsers:
        my @decl4 = (<<'XS', q{);
nananana
XS
batman
});

        my @decl5 = (q{);
batman
}, <<'XS');
nananana
XS

is __LINE__, 38, "The filter (resp. heredocs) doesn't ruin line numbers";
is $decl, "foo\n";
is $decl2, "bar\n";
is_deeply \@decl3, ["nananana\n","batman\n"];
is_deeply \@decl4, ["nananana\n",");\nbatman\n"];
is_deeply \@decl5, [");\nbatman\n","nananana\n"];
