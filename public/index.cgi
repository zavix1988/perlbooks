#!/usr/bin/perl -w
use CGI qw(:cgi-lib :escapeHTML :unescapeHTML);
use CGI::Carp qw(fatalsToBrowser); # позволит выводить ошибки в браузер
use Switch;
use vars qw(%in);
use Data::Dumper;
use File::Basename qw(dirname);
use lib dirname(__FILE__);


$|=1; # отключаем буферизацию ввода данных;
ReadParse(); # получает данные из HTML формы в  хэш %in

# вариант хедера, используется перед выводом в браузер
print "Content-type: text/html; charset=utf-8\n\n";
#print "Hello, world";
#print "<pre>";
#print Dumper($ENV{QUERY_STRING});
#print "</pre>";
#print "<pre>";
#print Dumper(\%ENV);
#print "</pre>";

my $string = $ENV{QUERY_STRING};
my @array = split('/', $string);
#print "<pre>";
$controller =  $array[0];
#print "</pre>";



my $books = '../app/view/books.html';
my $view = '../app/view/';

switch ($controller){
    case "books" {
        open(my $fh, '<:encoding(UTF-8)', $books);
        local $/ = undef;
        my $html = <$fh>;
        close $fh;
        print $html;
    }
    case "Book" {
        my $book = $array[1];
        open(my $fh, '<:encoding(UTF-8)', $view.$book.'.html');
        local $/ = undef;
        my $html = <$fh>;
        close $fh;
        print $html;
    }
}