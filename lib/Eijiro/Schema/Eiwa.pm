package Eijiro::Schema::Eiwa;
use strict;
use warnings;
use base qw/DBIx::Class/;

__PACKAGE__->load_components(qw/PK::Auto Core DB/);
__PACKAGE__->table('eiwa');
__PACKAGE__->add_columns(qw/id term description part/);
__PACKAGE__->set_primary_key('id');

1;
