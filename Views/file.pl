use strict;
use warnings;

my $page;

open(my $stream, '<:encoding(UTF-8)', 'Views/layouts/header.html') or die ('sdsd');
local $/ = undef;
my $header = <$stream>;
close $stream;

$page .= $header;

$page .= '<div class="container">
    <h1 class="text-center">Книги</h1>
    <hr/>
    <div class="row">
        <div class="col-md-2">
            <h4>Фильтр</h4>
            <form class="form" action="/filter" method="get">
                <div class="form-group">
                    <label for="author">Автор</label>
                    <select name="author" class="form-control" id="lang">
                        <option value="0" selected>Автор</option>';



foreach my $author ($content->{'authors'}){
    print Dumper($author);
}

#foreach my $authors

#foreach my $book (@books){

#}

#my $content =
#print Dumper(@books);

return 1;



