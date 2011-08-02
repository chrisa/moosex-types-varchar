package MooseX::Types::Varchar;
use strict;
use warnings;

use 5.008;
our $VERSION = '0.03';

use MooseX::Types::Parameterizable qw(Parameterizable);
use MooseX::Types -declare => ['Varchar'];
use MooseX::Types::Moose qw/ Str Int /;
use namespace::clean;

subtype Varchar,
      as Parameterizable[Str,Int],
      where {
        my($string, $int) = @_;
        $int >= length($string) ? 1:0;
      },
      message {
        my ($val, $constraining) = @_;
        qq{Validation failed for 'MooseX::Types::Varchar[$constraining]' with value "$val"};
      };

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
is paramterizable.

=head1 EXPORTS

Nothing by default. You will want to request "Varchar", provided as a
MooseX::Types type.

=head1 SEE ALSO

=over

=item L<MooseX::Types>

=item L<MooseX::Types::Parameterizable>

=back

=head1 AUTHOR

Chris Andrews <chris@nodnol.org>

=head1 COPYRIGHT

This program is Free software, you may redistribute it under the same
terms as Perl itself.

=cut

