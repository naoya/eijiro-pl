package Eijiro::Parser;
use strict;
use warnings;
use Jcode;
use Eijiro::Parser::Item;

sub new {
    bless {}, shift;
}

sub parse_line {
    my ($self, $line) = @_;
    chomp $line;
    return unless $line;
    my $data = {};
    $line = Jcode->new($line, 'sjis')->euc;
    ($data->{term}, $data->{description}) = $line =~ m!¢£(.*?)\s+:\s+(.+)$!;
    $data->{part} = $1 if $data->{term} =~ s/\s+{(.+)}$//g;
    return Eijiro::Parser::Item->new($data);
}

1;
