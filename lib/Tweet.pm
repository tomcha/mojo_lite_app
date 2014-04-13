package Tweet;

use strict;
use warnings;
use utf8;

use Data::Dumper;
use Net::Twitter::Lite::WithAPIv1_1;
use Config::PL;

#binmode STDIN,":encoding(UTF8)";
#binmode STDOUT,":utf8";

sub new{
    my $class = shift;
    my $twitter_id = shift;
    my $self = {
        twitter_id  => $twitter_id,
    };
    return bless $self, $class;
}

sub get_tweets{
    my $self = shift;
    my %twit_conf = config_do 'config.pl';
    my $nt = Net::Twitter::Lite::WithAPIv1_1->new(
        consumer_key        => $twit_conf{consumer_key},
        consumer_secret     => $twit_conf{consumer_secret},
        access_token        => $twit_conf{access_token},
        access_token_secret => $twit_conf{access_token_secret},
        ssl                 => 1,
    );

    my $result = $nt->user_timeline({screen_name => $self->{twitter_id},count => 300});
    my @good_tweets;
    for my $str (@$result){
        push(@good_tweets,$str->{text}) if length($str->{text}) < 15 && $str->{text} !~ /@/;
    }
    return \@good_tweets;
};

1;
