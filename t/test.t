#!perl

use strict;
use warnings;
use Test2::V0;

use Hash::Helper;

subtest "Defined subset" => sub {
    my %hash_with_undefs = (
        key1 => "defined",
        key2 => undef
    );

    my %expected = (
        key1 => "defined"
    );

    is { Hash::Helper::defined_subset( \%hash_with_undefs ) }, \%expected,
        "defined_subset";
    is { Hash::Helper::dsubset( \%hash_with_undefs ) }, \%expected,
        "dsubset";
};

subtest "Defined slice" => sub {
    my %hash_with_undefs = (
        key1 => "defined",
        key2 => undef,
    );

    my @slice = qw(key1 key2 key3);

    my %expected = (
        key1 => "defined"
    );

    is { Hash::Helper::defined_slice( \%hash_with_undefs, @slice ) }, \%expected,
        "defined_slice";
    is { Hash::Helper::dslice( \%hash_with_undefs, @slice ) }, \%expected,
        "dslice";
};

subtest "Exists slice" => sub {
    my %hash_with_undefs = (
        key1 => "defined",
        key2 => undef,
    );

    my @slice = qw(key1 key2 key3);

    my %expected = (
        key1 => "defined",
        key2 => undef
    );

    is { Hash::Helper::exists_slice( \%hash_with_undefs, @slice ) }, \%expected,
        "exists_slice";
    is { Hash::Helper::eslice( \%hash_with_undefs, @slice ) }, \%expected,
        "eslice";
};

subtest "Transform slice" => sub {
    my %hash_with_undefs = (
        key1 => "defined",
        key2 => undef,
    );

    my %slice = (
        key1 => "Defined Key",
        key2 => "Undef Key",
        key3 => "Missing Key",
    );

    my %expected = (
        "Defined Key" => "defined",
        "Undef Key" => undef,
        "Missing Key" => undef,
    );

    is { Hash::Helper::transform_slice( \%hash_with_undefs, %slice ) }, \%expected,
        "transform_slice";
    is { Hash::Helper::xfslice( \%hash_with_undefs, %slice ) }, \%expected,
        "xfslice";
};

subtest "Transform defined slice" => sub {
    my %hash_with_undefs = (
        key1 => "defined",
        key2 => undef,
    );

    my %slice = (
        key1 => "Defined Key",
        key2 => "Undef Key",
        key3 => "Missing Key",
    );

    my %expected = (
        "Defined Key" => "defined",
    );

    is { Hash::Helper::transform_defined_slice( \%hash_with_undefs, %slice ) }, \%expected,
        "transform_defined_slice";
    is { Hash::Helper::xfdslice( \%hash_with_undefs, %slice ) }, \%expected,
        "xfdslice";
};

subtest "Transform exists slice" => sub {
    my %hash_with_undefs = (
        key1 => "defined",
        key2 => undef,
    );

    my %slice = (
        key1 => "Defined Key",
        key2 => "Undef Key",
        key3 => "Missing Key",
    );

    my %expected = (
        "Defined Key" => "defined",
        "Undef Key" => undef,
    );

    is { Hash::Helper::transform_exists_slice( \%hash_with_undefs, %slice ) }, \%expected,
        "transform_exists_slice";
    is { Hash::Helper::xfeslice( \%hash_with_undefs, %slice ) }, \%expected,
        "xfeslice";
};
done_testing;
