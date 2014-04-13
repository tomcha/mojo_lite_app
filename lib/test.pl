#!/usr/bin/env perl

use strict;
use warnings;
use utf8;

#use feature '5.010';
use Data::Dumper;
use Tweet;

binmode STDIN,":encoding(UTF8)";
binmode STDOUT,":utf8";
binmode STDERR,":utf8";

my $twitter_name = shift;
my $instance = Tweet->new($twitter_name);
for my $string (@{$instance->get_tweets}){
    print "$string\n";
}
#print Dumper $instance->get_tweets;
