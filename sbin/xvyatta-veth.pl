#!/usr/bin/perl

use strict;

my %ifhash;
my @iflist = `ls /sys/class/net`;

foreach my $if (@iflist) {
	if ($if =~ /^veth[0-9]+/) {
		$ifhash{$&} = 1;
	}
}

foreach my $if (sort keys %ifhash) { print $if, "\n"; }
