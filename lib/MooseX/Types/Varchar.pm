package MooseX::Types::Varchar;
use strict;
use warnings;

use 5.008;
our $VERSION = '0.03';

use MooseX::Types -declare => ['Varchar'];

use Moose::Meta::TypeConstraint::Parameterized;
use Moose::Util::TypeConstraints;
use MooseX::Types::Moose qw/ Str Int /;
use namespace::clean;

use base qw/ Moose::Meta::TypeConstraint::Parameterizable /;

sub _parse_type_parameter {
    my ($self, $type_parameter) = @_;
    Moose->throw_error(qq{Type parameter '$type_parameter' for Varchar is not an Int})
        unless is_Int($type_parameter);

    return type $type_parameter, # Evil, this shits a type called '20' which checks $_ < 20 into the global
                                 # type constraint registry.
        where { length($_) <= $type_parameter};
}

my $tc = __PACKAGE__->new(
        name                 => Varchar,
        package_defined_in   => __PACKAGE__,
        parent               => find_type_constraint( Str ),
        constraint           => sub {1},
        constraint_generator => sub {
                my $type_parameter = shift;
                my $check          = $type_parameter->_compiled_type_constraint;
                return sub {
                        return $check->($_);
                };
        },
);

register_type_constraint($tc);
Moose::Util::TypeConstraints::add_parameterizable_type($tc);

1;

__END__

=head1 NAME

MooseX::Types::Varchar - Str type parameterizable by length.

=head1 SEE INSTEAD

You probably don't want this - L<MooseX::Types::Parameterizable> is
the more general solution.

=head1 SYNOPSIS

  package MyClass;
  use Moose;
  use MooseX::Types::Varchar qw/ Varchar /;

  has 'attr1' => (is => 'rw', isa => Varchar[40]);

  package main;
  my $obj = MyClass->new( attr1 => 'this must be under 40 chars' );

=head1 DESCRIPTION

This module provides a type based on Str, where a length restriction
is paramterizable.

=head1 EXPORTS

Nothing by default. You will want to request "Varchar", provided as a
MooseX::Types type.

=head1 AUTHOR

Chris Andrews <chris@nodnol.org>

=head1 COPYRIGHT

This program is Free software, you may redistribute it under the same
terms as Perl itself.

=cut

