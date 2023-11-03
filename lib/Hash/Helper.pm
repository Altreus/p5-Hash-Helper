package Hash::Helper;
use strict;
use warnings;

our $VERSION = 0.001;

# ABSTRACT: Common hash manipulation functions

use Exporter 'import';
our %EXPORT_TAGS = (
    verbose => [qw(
        defined_subset defined_slice  exists_slice transform_slice
        transform_defined_slice transform_exists_slice
    )],
    short => [ qw (
        dsubset dslice eslice txslice txdslice txeslice
    )]
);
our @EXPORT_OK = ( $EXPORT_TAGS{verbose}->@*, $EXPORT_TAGS{short}->@* );


=head1 DESCRIPTION

I keep rewriting the same functions to manipulate hashes. You probably do, as
well.

When this was a problem for arrays, we got L<List::Util>, but there doesn't
seem to be an equivalent for hashes. (Note that L<Hash::Util> exists, but it
contains much more specialised functions than these.)

This module is just a container for a few functions we keep rewriting.

=head1 SYNOPSIS

    use Hash::Helper qw(:verbose);

    my %hash = defined_subset( \%other_hash );
    my %hash = defined_slice( \%other_hash, qw(key1 key2) );
    my %hash = exists_slice( \%other_hash, qw(key1 key2) );
    my %hash = transform_slice( \%other_hash, firstname => "FirstName" );
    my %hash = transform_defined_slice( \%other_hash, firstname => "FirstName" );
    my %hash = transform_exists_slice( \%other_hash, firstname => "FirstName" );

=head1 EXPORTS

Nothing is exported by default because that's naughty.

Instead, each function can be explicitly requested on the import line.

You can also use the tags C<:verbose> or C<:short> to import the long or short
forms of all functions.

Each function below lists first its C<verbose> name, then its C<short> name.

=head1 FUNCTIONS

=head2 defined_subset

=head2 dsubset

    my %new_hash = defined_subset( \%old_hash );

Returns a key-value pair list of the subset of the input hash whose values
were defined.

Exactly equivalent to:

    map { defined $oldhash{$_} ? $_ => $oldhash{$_} : () } keys %oldhash

=cut

sub defined_subset {
    my $href = shift;
    return defined_slice( $href, keys %$href );
}

*dsubset = \&defined_subset;

=head2 defined_slice

=head2 dslice

    my %new_hash = defined_slice( \%old_hash, qw( key1 key2 ) );

Returns a slice of the input hash, using the given keys, only where the values
in the input hash are defined. Using standard Perl rules, nonexistent keys
are undefined.

You could also write this as

    defined_subset( { %old_hash{qw(key1 key2)} } )

but that's a bit more verbose and does extra operations. (In fact,
C<defined_subset> is written in terms of C<defined_slice>.)

=cut

sub defined_slice {
    my $href = shift;
    my @keys = @_;

    my %ret = map { defined $href->{$_} ? ($_ => $href->{$_}) : () } @keys;
    return %ret;
}

*dslice = \&defined_slice;

=head2 exists_slice

=head2 eslice

    my %new_hash = exists_slice( \%old_hash, qw( key1 key2 ) );

Returns a slice of the input hash, using the given keys, only where those keys
exist in the input hash.

=cut

sub exists_slice {
    my $href = shift;
    my @keys = @_;

    my %ret = map { exists $href->{$_} ? ($_ => $href->{$_}) : () } @keys;
    return %ret;
}

*eslice = \&exists_slice;

=head2 transform_slice

=head2 txslice

    my %new_hash = transform_slice( \%old_hash, oldkey => 'newkey' );

Returns a slice of the input hash with transformed keys. Note that the keys
are a key-value list, not a hashref. The key from the transform list is used
against the input hash, and the corresponding value is used as the key in the
returned hash.

=cut

sub transform_slice {
    my $hash = shift;
    my %transformations = @_;

    my %ret;

    for my $k (keys %transformations) {
        $ret{ $transformations{$k} } = $hash->{$k};
    }

    return %ret;
}

*txslice = \&transform_slice;

=head2 transform_defined_slice

=head2 txdslice

    my %new_hash = transform_defined_slice( \%old_hash, oldkey => 'newkey' );

Exactly as L</transform_slice>, except only those values that are defined in
the input hash are included (under their new key) in the output hash.

=cut

sub transform_defined_slice {
    my $hash = shift;
    my %transformations = @_;

    # This could be defined_subset · transform_slice, but that would involve
    # extra hashing that we avoid by doing it this way.
    my %ret;

    for my $k (keys %transformations) {
        $ret{ $transformations{$k} } = $hash->{$k} if defined $hash->{$k};
    }

    return %ret;
}

*txdslice = \&transform_defined_slice;

=head2 transform_exists_slice

=head2 txdslice

    my %new_hash = transform_exists_slice( \%old_hash, oldkey => 'newkey' );

Exactly as L</transform_slice>, except only those keys that exist in the input
hash are included (under their new name) in the output hash.

=cut

sub transform_exists_slice {
    my $hash = shift;
    my %transformations = @_;

    # This could be defined_subset · transform_slice, but that would involve
    # extra hashing that we avoid by doing it this way.
    my %ret;

    for my $k (keys %transformations) {
        $ret{ $transformations{$k} } = $hash->{$k} if exists $hash->{$k};
    }

    return %ret;
}

*txeslice = \&transform_exists_slice;

1;
