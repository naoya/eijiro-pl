package Eijiro::Command::Init;
use strict;
use warnings;
use IO::File;

sub do {
    my ($class, $eijiro) = @_;
    my $text = shift @ARGV or die "usage: $0 --init <text>";
    my $io = IO::File->new($text, "r") or die $!;
    $eijiro->initdb;
    while (my $line = $io->getline) {
        my $item = $eijiro->parser->parse_line($line);
        $eijiro->append_item($item);
    }
    $io->close;
}

1;

