package MDB::db;
use strict;
use warnings;
use MDB::driver;

sub new {
    my $class = ref($_[0]) || $_[0];
    my $self = {};
    $self->{'driver'} = MDB::driver->new();
    return bless($self, $class);
}

sub findAll {
    my ($self, $table) = @_;
    my $query = 'SELECT * FROM ' . $table;

    if(my @result = $self->{'driver'}->query($query)) {
        return @result;
    }
}

sub findOne {
    my ($self, $table, $id) = @_;
    my $query = 'SELECT * FROM ' . $table . ' WHERE id = ' . $id . ' LIMIT 1';
    if(my @result = $self->{'driver'}->query($query)) {
        return @result;
    }
}

sub  findBookByAuthorGenreId{
    my ($self, $authorId, $genreId) = @_;
    my $query = "SELECT books.id, books.name, books.slug, books.price, books.pubyear, books.lang, books.description FROM books
                      LEFT JOIN book_author ON books.id=book_author.book_id
                      LEFT JOIN book_genre ON books.id=book_genre.book_id
                WHERE book_author.author_id = " . $authorId . " OR book_genre.genre_id = " . $genreId . "
                GROUP BY books.id";

    if(my @result = $self->{'driver'}->query($query)) {
        return @result;
    }
}

1;