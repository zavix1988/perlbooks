package Models::Authors;
use strict;
use warnings FATAL => 'all';
use File::Basename qw(dirname);
use lib '../'.dirname(__FILE__).'/Libs/';
use Driver;
use Data::Dumper;

my $connection;
my $table = 'authors';

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

sub findByBookId
{
    my ($self, $id) = @_;
    my $sql = "SELECT * FROM book_author LEFT JOIN $table ON book_author.author_id=$table.id WHERE book_id = $id";
    return $connection->query($sql);
}

1;