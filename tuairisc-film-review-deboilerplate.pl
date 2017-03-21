#!/usr/bin/perl

use warnings;
use strict;
use utf8;

use URI;
use HTML::TreeBuilder::XPath;
use Data::Dumper;
binmode(STDOUT, ":utf8");

my $url = 'http://tuairisc.ie/deantar-an-kong-e-fein-a-shamhlu-go-snasta-ce-nach-gcuirtear-fe-dhraiocht-sinn/';

my $tree = HTML::TreeBuilder::XPath->new_from_url($url);
#my $p = $tree->findnodes('//div[@class="article--full__content"]/p');

my $nodes = $tree->findnodes('//div[@class="article--full__content"]/p/span');
for my $n ($nodes->string_values()) {
	print "$n\n";
}


#print Dumper $nodes[0];
