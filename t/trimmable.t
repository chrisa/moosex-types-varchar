use strict;
use warnings;
use Test::More;
{
    package MyClass;
    use Moose;
    use MooseX::Types::Varchar qw/ TrimmableVarchar /;

    has 'attr1' => (is => 'rw', required => 1, isa => TrimmableVarchar[20]);
    has 'attr2' => (is => 'rw', required => 1, isa => TrimmableVarchar[20], coerce => 1);
    no Moose;
}

my $long = 'This is over twenty characters long.';
eval {
        my $obj = MyClass->new( attr1 => $long, attr2 => $long );
};
ok $@, 'Got exception';
like($@, qr/Validation failed for/);
like( $@, qr/This is over twenty characters long/,
    'check Varchar[20] is respected');

my $obj;
eval {
        $obj = MyClass->new( attr1 => q{This isn't.}, attr2 => $long );
};
ok(!$@, 'short-enough string')
    or diag $@;
is $obj->attr2, substr($long, 0, 20), 'Is trimmed as expected';

done_testing;
