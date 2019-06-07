package Controllers::MainController;
use strict;
use warnings FATAL => 'all';
use File::Basename qw(dirname);
use lib '../'.dirname(__FILE__).'/Models/';
use Models::Books;
use Models::Genres;
use Models::Authors;

use Data::Dumper;

my $books;
my $authors;
my $genres;

sub new
{
    my $class = ref($_[0]) || $_[0];
    my $self = {};
    $books = Models::Books->new();
    $genres = Models::Genres->new();
    $authors = Models::Authors->new();
    return bless($self, $class);
}

sub indexAction {
    my ($self) = @_;
    my $title = 'Main';
    my @allBooks = $books->findAll();
    my @allGenres = $genres->findAll();
    my @allAuthors = $authors->findAll();
    my  @newBooks;
    foreach my $book( @allBooks ){
        $book->{'bookGenres'} = \$genres->findByBookId($book->{'id'});
        $book->{'bookAuthors'} = \$authors->findByBookId($book->{'id'});
        push @newBooks, $book;
    }
    return @newBooks;
}


1;

