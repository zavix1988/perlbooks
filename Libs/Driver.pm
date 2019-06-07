package Driver;
use strict;
use warnings FATAL => 'all';

use Data::Dumper;
use DBI;

my $dbh;
sub new
{
    my $class = ref($_[0]) || $_[0];
    my $self = {};
    my $host = 'dbi:mysql:host=127.0.0.1;dbname=user12;';
    my $user = 'user12';
    my $pass = 'user12';
    $dbh = DBI->connect($host, $user, $pass, {});
    my $sql = qq{SET NAMES 'utf8';};
    $dbh->do($sql);
    return bless($self, $class);
}

sub query
{
    my($self, $sql) = @_;

    my $query = $dbh->prepare($sql);

    my @data_array;
    if (my $cnt = $query->execute())
    {
        while (my $row = $query->fetchrow_hashref())
        {
            push @data_array, $row;
        }
        $query->finish();
        return @data_array;
    }
    return 0;
}

sub DESTROY
{
    if (defined($dbh))
    {
        $dbh->disconnect;
    }
}
1;