# NAME

Hash::Helper - Common hash manipulation functions

# VERSION

version 0.001

# SYNOPSIS

```
use Hash::Helper qw(:verbose);

my %hash = defined_subset( \%other_hash );
my %hash = defined_slice( \%other_hash, qw(key1 key2) );
my %hash = exists_slice( \%other_hash, qw(key1 key2) );
my %hash = transform_slice( \%other_hash, firstname => "FirstName" );
my %hash = transform_defined_slice( \%other_hash, firstname => "FirstName" );
my %hash = transform_exists_slice( \%other_hash, firstname => "FirstName" );
```

# DESCRIPTION

I keep rewriting the same functions to manipulate hashes. You probably
do, as well.

When this was a problem for arrays, we got List::Util, but there
doesn't seem to be an equivalent for hashes. (Note that Hash::Util
exists, but it contains much more specialised functions than these.)

This module is just a container for a few functions we keep rewriting.

# EXPORTS

Nothing is exported by default because that's naughty.

Instead, each function can be explicitly requested on the import line.

You can also use the tags `:verbose` or `:short` to import the long or
short forms of all functions.

Each function below lists first its verbose name, then its short name.

# FUNCTIONS

## `defined_subset`

## `dsubset`

    my %new_hash = defined_subset( \%old_hash );

Returns a key-value pair list of the subset of the input hash whose
values were defined.

Exactly equivalent to:

    map { defined $oldhash{$_} ? $_ => $oldhash{$_} : () } keys %oldhash

## `defined_slice`

## `dslice`

    my %new_hash = defined_slice( \%old_hash, qw( key1 key2 ) );

Returns a slice of the input hash, using the given keys, only where the
values in the input hash are defined. Using standard Perl rules,
nonexistent keys are undefined.

You could also write this as

    defined_subset( { %old_hash{qw(key1 key2)} } )

but that's a bit more verbose and does extra operations. (In fact,
`defined_subset` is written in terms of defined_slice.)

## `exists_slice`

## `eslice`

    my %new_hash = exists_slice( \%old_hash, qw( key1 key2 ) );

Returns a slice of the input hash, using the given keys, only where
those keys exist in the input hash.

## `transform_slice`

## `txslice`

    my %new_hash = transform_slice( \%old_hash, oldkey => 'newkey' );

Returns a slice of the input hash with transformed keys. Note that the
keys are a key-value list, not a hashref. The key from the transform
list is used against the input hash, and the corresponding value is
used as the key in the returned hash.

## `transform_defined_slice`

## `txdslice`

    my %new_hash = transform_defined_slice( \%old_hash, oldkey => 'newkey' );

Exactly as `transform_slice`, except only those values that are defined
in the input hash are included (under their new key) in the output
hash.

## `transform_exists_slice`

## `txeslice`

    my %new_hash = transform_exists_slice( \%old_hash, oldkey => 'newkey' );

Exactly as `transform_slice`, except only those keys that exist in the
input hash are included (under their new name) in the output hash.

# AUTHOR

Alastair Douglas <altreus@altre.us>

# COPYRIGHT AND LICENSE

This software is Copyright (c) 2023 by Alastair Douglas.

This is free software, licensed under:

  The MIT (X11) License

