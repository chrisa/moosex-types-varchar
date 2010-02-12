package MooseX::Types::Varchar;
use strict;
use warnings;

use 5.008;
our $VERSION = '0.01';

use MooseX::Types -declare => ['Varchar'];

use Moose::Meta::TypeConstraint::Parameterized;
use Moose::Util::TypeConstraints qw/ register_type_constraint
                                     find_type_constraint /;

use base qw/ Moose::Meta::TypeConstraint::Parameterizable /;

sub parameterize {
        my ($self, $length) = @_;
        my $contained_tc = $self->_parse_type_parameter($length);

        my $tc_name = $self->name . '[' . $length . ']';
        my $parameterized = Moose::Meta::TypeConstraint::Parameterized->new(
            name           => $tc_name,
            parent         => $self,
            type_parameter => $contained_tc,
            message        => sub {
                    my $value = shift;
                    return "'$value' is too long for attribute type Varchar[$length]"
            },
        );
        return $parameterized;
}

my $tc = MooseX::Types::Varchar->new(
        name                 => Varchar,
        package_defined_in   => __PACKAGE__,
        parent               => find_type_constraint('Str'),
        constraint           => sub {1},
        constraint_generator => sub {
                my $length = shift;
                return sub {
                        return 1 if defined $_ && length $_ <= $length;
                        return;
                }
        },
);

register_type_constraint($tc);
Moose::Util::TypeConstraints::add_parameterizable_type($tc);

1;

__END__

=head1 NAME

MooseX::Types::Varchar - Str type parameterizable by length.

=head1 SYNOPSIS

  package MyClass;
  use Moose;
  use MooseX::Types::Varchar qw/ Varchar /;

  has 'attr1' => (is => 'rw', isa => Varchar[40]);

  package main;
  my $obj = MyClass->new( attr1 => 'this must be under 40 chars' );

=head1 DESCRIPTION

This module provides a type based on Str, where a length restriction
is paramterizable. You get a customised message indicating that there
is a length restriction on the attribute:

  '... long string ...' is too long for attribute type Varchar[20]

=head1 EXPORTS

Nothing by default. You will want to request "Varchar", provided as a
MooseX::Types type.

=head1 BUGS

You can't really usefully subtype these. If you do the constraint will be
applied to the subtype, but the message will not. 

=head1 AUTHOR

Chris Andrews <chris@nodnol.org>

=head1 COPYRIGHT

This program is Free software, you may redistribute it under the same
terms as Perl itself.

=cut
