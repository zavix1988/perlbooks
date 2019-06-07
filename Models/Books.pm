package Models::Books;
use strict;
use warnings FATAL => 'all';
use File::Basename qw(dirname);
use lib '../'.dirname(__FILE__).'/Libs/';
use Driver;
use Data::Dumper;

my $connection;
my $table = 'books';

sub new
{
    my $class = ref($_[0]) || $_[0];
    my $self = {};
    $connection = Driver->new();
    return bless($self, $class);
}

sub findAll {
    my ($self) = @_;
    my $sql = "SELECT * FROM $table";
    return $connection->query($sql)
}

sub findOne {
    my ($self, $id) = @_;
    my $sql = "SELECT * FROM $table WHERE id = $id";
    return $connection->query($sql);
}


sub findByAuthorGenreId {
    my ($self, $authorId, $genreId) = @_;
    my $sql = "SELECT books.id, books.name, books.slug, books.price, books.pubyear, books.lang, books.description FROM $table
                      LEFT JOIN book_author ON books.id=book_author.book_id
                      LEFT JOIN book_genre ON books.id=book_genre.book_id
                WHERE book_author.author_id = $authorId OR book_genre.genre_id = $genreId
                GROUP BY books.id";
    return $connection->query($sql);

}

1;