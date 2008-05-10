package Eijiro::Command;
use strict;
use warnings;
use UNIVERSAL::require;
use Getopt::Long;

sub factory {
    my ($class, $eijiro) = @_;
    GetOptions(
        init        => \my $init,
        'lines|n=i' => \my $lines,
    );
    $eijiro->lines($lines) if $lines;

    my $command = join '::', __PACKAGE__, $init ? 'Init' : @ARGV ? 'Argv' : 'Terminal';
    $command->require;
    die $@ if $@;
    return $command;
}

1;
