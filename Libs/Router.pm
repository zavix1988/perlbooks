package Libs::Router;
use strict;
use warnings FATAL => 'all';

use Data::Dumper;


sub new{
    my $class = ref($_[0])||$_[0];
    my $self = {};
    return bless{$self, $class};
}

sub dispatch {
    my ($self, %IN) = @_;

}

1;