package Eijiro::Driver;
use strict;
use warnings;
use UNIVERSAL::require;

sub new {
    bless {}, shift;
}

sub factory {
    my ($class, $text) = @_;
    my $type = $text =~ /^[\x00-\x7f]*$/ ? 'Eiwa' : 'Waei';
    my $driver = join '::', __PACKAGE__, $type;
    $driver->require;
    die $@ if $@;
    return $driver->new;
}

1;
