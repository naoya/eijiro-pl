package Eijiro;
use strict;
use warnings;
use base qw/Class::Accessor::Fast/;
use Carp;

our $VERSION = 0.02;

use File::Spec;
use Eijiro::Schema;
use Eijiro::History;
use Eijiro::Driver;
use Eijiro::Command;

__PACKAGE__->mk_accessors(qw/schema history lines/);

sub new {
    my $class = shift;
    my $self = bless {}, $class;
    $self->_init(@_);
    $self;
}

sub _init {
    my $self = shift;
    my %args = @_;
    my $dbfile = $args{dbfile} or croak "usage Eijiro->new(dbfile => '/path/to/eijiro.db')";
    my $historyfile = $args{historyfile} || File::Spec->catfile($ENV{HOME}, '.eijirohistory');
    $self->schema(Eijiro::Schema->connect(
        "dbi:SQLite:$dbfile",
        { on_connect_do => ['PRAGMA case_sensitive_like=ON;'] }
    ));
    $self->history(Eijiro::History->new({ filename => $historyfile }));
}

sub parser {
    my $self = shift;
    require Eijiro::Parser;
    $self->{parser} ||= Eijiro::Parser->new;
}

sub append_item {
    my ($self, $item) = @_;
    croak "Invalid object was passed" unless $item->isa('Eijiro::Parser::Item');
    return Eijiro::Driver->factory($item->term)->append($self, $item);
}

sub translate {
    my ($self, $line) = @_;
    $line or return;
    return Eijiro::Driver->factory($line)->translate($self, $line);
}

sub initdb {
    shift->schema->init_table;
}

sub run_as_command {
    my $self = shift;
    Eijiro::Command->factory($self)->do($self);
}

1;
