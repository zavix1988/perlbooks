#!/usr/bin/perl
use strict;
use warnings;

use CGI qw(:cgi-lib :escapeHTML :unescapeHTML);
use CGI::Carp qw(fatalsToBrowser);
use vars qw(%in);
use Data::Dumper;
use File::Basename qw(dirname);
use lib dirname(__FILE__);
use lib dirname(__FILE__).'/Libs/';
use lib dirname(__FILE__).'/Views/';

use Controllers::MainController;
use Libs::Router;

my $url = $ENV{'REQUEST_URI'};

$|=1; # отключаем буферизацию ввода данных;
ReadParse(); # получает данные из HTML формы в  хэш %in
print "Content-type: text/html; charset=utf-8\n\n";

eval
{
    my $router = Libs::Router->new();
    my $route = $router->getRoute('route','main/index');

    my $controller =  $route->{'controller'};
    my $action =  $route->{'action'};
    my $params =  $route->{'params'};

    print $controller;
    print $action;
    print $params;

    require $controller.".pm";
    my $controller_class = "Controllers::$controller";
    $controller = $controller_class->new();
    $controller->setContainer();

    if($controller->can($action))
    {
        $controller->draw($controller->$action($params));
    }
    else
    {
        Libs::MyException->new()->getErrorPage('error/page_not_found.pl');
    }
};