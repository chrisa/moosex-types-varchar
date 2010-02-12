use strict;
use warnings;
use Test::More tests => 2;

package MyClass;
use Moose;
use MooseX::Types::Varchar qw/ Varchar /;

has 'attr1' => (is => 'rw', required => 1, isa => Varchar[20]);

package main;

eval {
        my $obj = MyClass->new( attr1 => 'This is over twenty characters long.' );
};
like($@, qr/'This is over twenty characters long\.' is too long for attribute type Varchar\[20\]/, 'check Varchar[20] is respected');

eval {
        my $obj = MyClass->new( attr1 => 'This isn\'t.' );
};
ok(!$@, 'short-enough string');


