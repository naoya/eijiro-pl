#!/usr/bin/env perl

use strict;
use warnings;
use Benchmark;
use FindBin;
use File::Spec;
use lib File::Spec->catdir($FindBin::Bin, '..', 'lib');
use Eijiro;
use Eijiro::Schema;

my $dbfile = File::Spec->catfile($FindBin::Bin, '..', 'db', 'eijiro.db');
my $eijiro = Eijiro->new(dbfile => $dbfile);
my $schema_case_sensitive   = Eijiro::Schema->connect("dbi:SQLite:$dbfile");
my $schema_case_insensitive = Eijiro::Schema->connect(
    "dbi:SQLite:$dbfile",
    { on_connect_do => ['PRAGMA case_sensitive_like=ON;'] }
);

timethese 100000, {
    case_insensitive => sub {
        $eijiro->schema($schema_case_insensitive);
        $eijiro->translate('うんこ');
    },
    case_sensitive => sub {
        $eijiro->schema($schema_case_sensitive);
        $eijiro->translate('うんこ');
    }
};

