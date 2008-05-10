package Eijiro::Schema;
use strict;
use warnings;
use base 'DBIx::Class::Schema';

__PACKAGE__->load_classes(qw/Eiwa Waei/);

sub init_table {
    my $self = shift;
    for my $table (qw/eiwa waei/) {
        $self->storage->dbh->do(<<SQL);
CREATE TABLE IF NOT EXISTS $table (
  id INTEGER PRIMARY KEY,
  term VARCHAR(128),
  description TEXT,
  part VARCHAR(16)
)
SQL
        $self->storage->dbh->do(<<SQL);
CREATE INDEX IF NOT EXISTS ${table}_term ON $table (term)
SQL
    }
}

1;
