package Eijiro::Command::Terminal;
use strict;
use warnings;
use base qw/Eijiro::Command::Printable/;
use Term::ReadLine;

sub do {
    my ($class, $eijiro) = @_;
    my $term = Term::ReadLine->new('Eijiro');
    $term->addhistory($_) for $eijiro->history->all;
    while ( defined ($_ = $term->readline('eijiro> ')) ) {
        exit if /^!exit/;
        $class->print($eijiro, $_);
        $eijiro->history->add($_);
    }
}

1;
