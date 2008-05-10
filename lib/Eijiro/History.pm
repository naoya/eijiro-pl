package Eijiro::History;
use strict;
use warnings;
use base 'Class::Accessor::Fast';
use File::Spec;
use IO::File;

__PACKAGE__->mk_accessors(qw/io filename/);

sub new {
    my $class = shift;
    my $self = $class->SUPER::new(@_);
    $self->_init(@_);
    bless $self, $class;
}

sub _init {
    my $self = shift;
    $self->io(IO::File->new($self->filename, "r+"));
}

sub all {
    my $self = shift;
    $self->io or return;
    my @h = $self->io->getlines;
    chomp @h;
    my %seen;
    grep { /\S/ && !$seen{$_}++ } @h;
}

sub add {
    my ($self, $line) = @_;
    $self->io->printf("%s\n", $line);
    $self;
}

sub DESTROY {
    my $self = shift;
    $self->io->close if $self->io;
}

1;
