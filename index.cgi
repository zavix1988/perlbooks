#!/usr/bin/perl
use strict;
use warnings;

use CGI qw(:cgi-lib :escapeHTML :unescapeHTML);
use CGI::Carp qw(fatalsToBrowser);
use vars qw(%in);
use Data::Dumper;
use File::Basename qw(dirname);
use lib dirname(__FILE__);
use lib dirname(__FILE__).'/libs/';
use lib dirname(__FILE__).'/app/';
use MDB::db;

$|=1; # отключаем буферизацию ввода данных;
ReadParse(); # получает данные из HTML формы в  хэш %in


my $string = $ENV{REQUEST_URI};
my $controller;



my @array = split('/', $string);
if(@array){
    $controller = @array[1];
}else{
    $controller ='';
}

print "Content-type: text/html; charset=utf-8\n\n";

#my $myObj = MDB::db->new();

#print Dumper($myObj->findAll('books'));
#print Dumper($myObj->findOne('books', 7));

#my $myObj = app::model::books->new();

my $model = MDB::db->new();

if($controller eq "book"){
    my @book = $model->findOne('books', @array[2]);
    my $string = '    <table class="table table-striped">
        <thead>
        <tr>
            <th>Название</th>
            <th>Цена</th>
            <th>Язык</th>
        </tr>
        </thead>
        <tbody>';
    foreach my $item (@book){
        $string .= '
        <tr style="text-align: center;">
            <td>' . $item->{'name'} . '</td>
            <td>' . $item->{'price'} . '</td>
            <td>' . $item->{'lang'} . '</td>
        </tr>
        <tr>
            <td colspan="3">' . $item->{'description'} . '</td>
        </tr>';
    }
    $string .=   '</tbody></table>';
    print $string;


}else{
    my @books = $model->findAll('books');
    my @authors = $model->findAll('authors');
    my %genres = $model->findAll('genres');
    my $string = '<div class="col-md-10">
    <table class="table table-striped">
        <thead>
            <tr>
                <th>Название</th>
                <th>Цена</th>
                <th>Язык</th>
                <th>Авторы</th>
                <th>Жанры</th>
            </tr>
        </thead>
        <tbody>';

    foreach my $book (@books){
        $string .= '<tr>
                        <td><a href="/book/'.$book->{id}.'">'.$book->{name}.'</a></td>
                        <td>'.$book->{price}.'</td>
                        <td>'.$book->{lang}.'</td>
                    </tr>';
    }
    $string .= '</tbody>
                </table>
                </div>';
    print $string;
}

