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

$|=1; # отключаем буферизацию ввода данных;
ReadParse(); # получает данные из HTML формы в  хэш %in
print "Content-type: text/html; charset=utf-8\n\n";

#Controllers::MainController->new();
#print Dumper(Controllers::MainController->indexAction());
my $template = 'file';
require $template.'.pl';