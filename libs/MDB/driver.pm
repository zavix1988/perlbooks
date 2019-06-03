package MDB::driver;
use strict;
use warnings ;
use DBI;
use Data::Dumper;

sub new {
    my $class = ref($_[0]) || $_[0];
    my $self = {};
    my $host = 'dbi:mysql:host=127.0.0.1;dbname=user12;';
    my $user = 'user12';
    my $pass = 'user12';
    $self->{'dbh'} = DBI->connect($host, $user, $pass, {});
    my $sql = qq{SET NAMES 'utf8';};
    $self->{'dbh'}->do($sql);
    return bless($self, $class);
}

sub execute {
    my ($self, $query, @params) = @_;
    my $sth = $self->{'dbh'}->prepare($query);
    my $res = $sth->execute(@params);
    if($res){
        return $res;
    }
    return $self->{'dbh'}->errstr;
}

sub query {
    my ($self, $query, @params) = @_;
    my $sth = $self->{'dbh'}->prepare($query);
    my $res = $sth->execute(@params);
    my @data_array;
    print Dumper(@params);
    if($res) {
        while (my $row=$sth->fetchrow_hashref())
        {
            push @data_array, $row;
        }
        $sth->finish();
        return @data_array;
    }
    return $self->{'dbh'}->errstr;
}


sub DESTROY {
    my ($self) = @_;
    $self->{'dbh'}->disconnect;
}

1;