package Eijiro::Command::Printable;
use strict;
use warnings;
use IO::File;
use Encode qw(from_to);
use Term::Encoding qw(term_encoding);

my $pager         = $ENV{PAGER} || 'less';
my $db_encoding   = 'euc-jp';
my $term_encoding = Term::Encoding::term_encoding;

sub print {
    my ($class, $eijiro, $line) = @_;
    $line or return;
    from_to($line, $term_encoding, $db_encoding);

    my @translated;
    if ($eijiro->lines) {
        @translated = ($eijiro->translate($line))[0..($eijiro->lines - 1)];
    }
    else {
        @translated = $eijiro->translate($line);
    }

    my $p = new IO::File ' | ' . ($eijiro->lines ? 'cat' : $pager);
    for my $item (@translated) {
        from_to(my $term = $item->term,        $db_encoding, $term_encoding);
        from_to(my $desc = $item->description, $db_encoding, $term_encoding);
        $p->printf("%s\n\t%s\n\n", $term, $desc);
    }
    $p->close;
}

1;
