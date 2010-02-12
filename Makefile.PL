use strict;
use warnings;

use ExtUtils::MakeMaker;

WriteMakefile(
	DISTNAME  => 'MooseX-Meta-TypeConstraint-Varchar',
	NAME      => 'MooseX::Meta::TypeConstraint::Varchar',
	AUTHOR    => 'Chris\ Andrews\ \<chris\@nodnol\.org\>',
	ABSTRACT  => 'A Str constraint parameterised by length',
	VERSION   => '0.01',
	EXE_FILES => [ qw() ],
	(eval { ExtUtils::MakeMaker->VERSION(6.21) } ? (LICENSE => 'perl') : ()),
	PREREQ_PM    => {
		"Moose" => '0',
	},
);
