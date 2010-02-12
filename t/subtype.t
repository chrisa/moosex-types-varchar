use strict;
use warnings;
use Test::More tests => 3;

package MyClass;
use Moose;
use MooseX::Types::Varchar qw/ Varchar /;
use Moose::Util::TypeConstraints;

subtype 'ThisType', as Varchar[20];

has 'attr1' => (is => 'rw', required => 1, isa => 'ThisType');

package main;

eval {
        my $obj = MyClass->new( attr1 => 'This is over twenty characters long.' );
};
ok($@);

TODO: {
        local $TODO = "message isn't propagated to subtypes";
        like($@, qr/'This is over twenty characters long\.' is too long for attribute type ThisType/, 'check subtyped Varchar is respected');
}

eval {
        my $obj = MyClass->new( attr1 => 'This isn\'t.' );
};
ok(!$@, 'short-enough string');


