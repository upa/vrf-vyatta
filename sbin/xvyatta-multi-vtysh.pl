#!/usr/bin/perl

#
# This script executes multiple vtysh commands
# to all namespaces.
#

use strict;

my @args;
foreach my $arg (@ARGV) {
    if ($arg =~ /\-c/) {
	push (@args, $arg);
    } else { 
	push (@args, "\"$arg\"");
    }
}

my @nslist = `ip netns list`;
my @vtyshes = ("/usr/bin/vtysh");
foreach my $ns (@nslist) {
    chomp ($ns);
    push (@vtyshes, "/usr/local/bin/vtysh -x /var/run/quagga-$ns");
}


foreach my $vty (@vtyshes) {
    my @c = (split (/ /, $vty), @args);
    my $ret = system (join (" ", @c));
    if ($ret != 0) {
	print "vtysh failed : " . join (" ", @c) . "\n";
	exit -1;
    }
}
