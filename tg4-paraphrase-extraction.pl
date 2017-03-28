#!/usr/bin/perl
# Simple scraper to extract a list of articles. By default, scans the first page;
# can accept a single argument of a page to scrape instead (for second and
# subsequent pages.
# Appends to a text file `tuairisc-film-review-uris.txt' in the current directory;
# outputs the URI of the next page of article listings, for next run
#
# Copyright (c) 2017 Trinity College, Dublin
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

use warnings;
use strict;
use utf8;

use URI;
use Web::Scraper;
use Encode;
use Data::Dumper;

my $films = 'http://www.tg4.ie/ga/nuacht/baile/';

open(LIST, '>>', 'tg4-paraphrases.txt');
binmode(LIST, ":utf8");

my $uri;
if($ARGV[0] && $ARGV[0] ne '') {
	$uri = URI->new($ARGV[0]);
} else {
	$uri = URI->new($films);
}

my $articles = scraper {
	process '//div[contains(@class, "news-item-wrap")]', 'articles[]' => scraper {
		process '//h4[contains(@class, "news-item-title")', 'title' => 'TEXT';
		process '//p[contains(@class, "news-item-desc")', 'desc' => 'TEXT';
	};
};

my $r = $articles->scrape($uri);

for my $art (@{$r->{articles}}) {
	print LIST $art->{'desc'} . " ||| " . $art->{'title'} . "\n";
}

#print Dumper $r;
