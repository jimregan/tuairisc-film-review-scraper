#!/usr/bin/perl

use warnings;
use strict;
use utf8;

use URI;
use HTML::TreeBuilder::XPath;
use Data::Dumper;
binmode(STDOUT, ":utf8");
open(LIST, "<tuairisc-film-review-uris.txt");

while(<LIST>) {
	chomp;
	my $url = $_;
	s/\/$//;
	s!http://tuairisc.ie/!!;
	my $filename = $_;
	$filename .= '.txt';
	open(OUT, ">", $filename);
	binmode(OUT, ":utf8");
	
	my $tree = HTML::TreeBuilder::XPath->new_from_url($url);

	my $nodes = $tree->findnodes('//div[@class="article--full__content"]/p');
	for my $n ($nodes->getChildNodes()) {
		if($tree->exists('./span', $n)) {
			for my $m ($n->findnodes('./span')) {
				print $m->string_value() . "\n";
			}
		} else {
			print OUT $n->string_value() . "\n";
		}
	}
}

