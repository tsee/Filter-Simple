#!perl -w
use strict;
use Test::More tests => 6 *3;

require Filter::Simple;

my $transform = Filter::Simple::gen_std_filter_for('code' => sub{});

sub transform_is_identity {
    my( $str ) = @_;
    
    my $expected = $str;
    
    my %names = ( "\n" => "\\n", "\r" => "\\r" );
    
    for my $newline ("\n", "\r\n", "\r") {
        my $name = "Transformation doesn't change [[$str]] with [$newline]";
        $name =~ s!([\r\n])!$names{$1}!ge;
        $str =~ s!\n!$newline!g;
        local $_ = $str;
        $transform->();
        is $_, $str, $name;
    };
};

transform_is_identity q{
        my $decl = <<'XS';
foo
XS
};

transform_is_identity q{
        my $decl2 = <<'XS'
bar
XS
;
};

transform_is_identity q{
        my $decl2 = <<'XS'

bar
XS
;
};
transform_is_identity q{
        my @decl3 = (<<'XS', <<'XS');
nananana
XS
batman
XS
};

# Especially devious, to trick simple-minded parsers:
transform_is_identity q[
        my @decl4 = (<<'XS', q{);
nananana
XS
batman
});
];


transform_is_identity q[
        my @decl5 = (q{);
batman
}, <<'XS');
nananana
XS
];
