package Eijiro::Schema::Waei;
use strict;
use warnings;
use base qw/DBIx::Class/;

__PACKAGE__->load_components(qw/PK::Auto Core DB/);
__PACKAGE__->table('waei');
__PACKAGE__->add_columns(qw/id term description part/);
__PACKAGE__->set_primary_key('id');

1;
