package Eijiro::Driver::Waei;
use strict;
use warnings;
use base qw/Eijiro::Driver/;

sub append {
    my ($self, $eijiro, $item) = @_;
    return $eijiro->schema->resultset('Waei')->create($item->to_hash);
}

sub translate {
    my ($self, $eijiro, $line) = @_;
    return $eijiro->schema->resultset('Waei')->search_like({ term => "$line%"});
}

1;
