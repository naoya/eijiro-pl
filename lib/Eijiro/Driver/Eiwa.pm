package Eijiro::Driver::Eiwa;
use strict;
use warnings;
use base qw/Eijiro::Driver/;

sub append {
    my ($self, $eijiro, $item) = @_;
    return $eijiro->schema->resultset('Eiwa')->create($item->to_hash);
}

sub translate {
    my ($self, $eijiro, $line) = @_;
    return $eijiro->schema->resultset('Eiwa')->search_like({ term => "$line%"});
}

1;
