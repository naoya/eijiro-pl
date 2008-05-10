package Eijiro::Command::Argv;
use strict;
use warnings;
use base qw/Eijiro::Command::Printable/;

sub do {
    my ($class, $eijiro) = @_;
    $class->print($eijiro, join ' ', @ARGV);
}

1;
