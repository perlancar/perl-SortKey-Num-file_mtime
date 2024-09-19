package SortKey::Num::file_mtime;

use 5.010001;
use strict;
use warnings;

# AUTHORITY
# DATE
# DIST
# VERSION

sub meta {
    return +{
        v => 1,
        args => {
            follow_symlink => {schema=>'bool*', default=>1},
        },
    };
}

sub gen_keygen {
    my %args = @_;

    my $follow_symlink = $args{follow_symlink} // 1;

    sub {
        my $arg = @_ ? shift : $_;
        my @st = $follow_symlink ? stat($arg) : lstat($arg);
        @st ? $st[9] : undef;
    }
}

1;
# ABSTRACT: File modification time as sort key

=for Pod::Coverage ^(meta|gen_keygen)$

=head1 SYNOPSIS

 use Sort::Key qw(nkeysort);
 use SortKey::Num::file_mtime;

 my $by_length = SortKey::Num::length::gen_keygen;
 my @sorted = &nkeysort($by_length, "newest", "old", "new"");


=head1 DESCRIPTION

This module provides sort key generator that assumes item is filename and
take the file's modification time (in Unix epoch) as key.


=head1 KEYGEN GENERATOR ARGUMENTS

=head2 follow_symlink

Bool, default true. If set to false, will use C<lstat()> function instead of the
default C<stat()>.

=cut
