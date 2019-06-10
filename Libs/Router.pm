package Libs::Router;
use strict;
use warnings FATAL => 'all';
use Data::Dumper;


sub new{
    my $class = ref($_[0])||$_[0];
    my $self = {};
    return bless{$self, $class};
}

sub getRoute{
    my ($self, $route, $default) = @_;
    my ($buffer, @pairs, $pair, $name, $value, $route_str, @route, $route_size, %hash_route);
    my %get = ();

    # Read get params

    $buffer = $ENV{'QUERY_STRING'};


    # Split information into name/value pairs
    @pairs = split(/&/, $buffer);

    # Make hash
    foreach $pair (@pairs)
    {
        ($name, $value) = split(/=/, $pair);


        $value =~ tr/+/ /;
        $value =~ s/%(..)/pack("C", hex($1))/eg;

        $get{$name} = $value;
    }


    $route_str = (exists $get{$route}) ? $get{$route} : $get{$route};

    #print $route_str.'<br>';


    @route = split m|/|, $route_str;

    print Dumper(@route);

    $route_size = @route;


    if($route_size <2)
    {
        @route = split m|/|, $default;       #redirect from default/homePage
    }

    %hash_route = ('controller'=>$route[0].'Controller', 'action'=> $route[1].'Action', 'params'=>$route[2]);
    return \%hash_route;

}

1;