#!/usr/local/bin/perl
use strict;
use warnings;

use FindBin;
use File::Spec;
use lib File::Spec->catdir($FindBin::Bin, '..', 'lib');
use Eijiro;

my $eijiro = Eijiro->new(
    dbfile => File::Spec->catfile($FindBin::Bin, '..', 'db', 'eijiro.db'),
);

$eijiro->run_as_command;
