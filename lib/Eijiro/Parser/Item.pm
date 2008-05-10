package Eijiro::Parser::Item;
use strict;
use warnings;
use base 'Class::Accessor::Fast';

my @Fields = qw/term description part/;

__PACKAGE__->mk_accessors(@Fields);

sub to_hash {
    my $self = shift;
    return { map { $_ => $self->$_ } @Fields }
}

1;

