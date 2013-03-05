#!/usr/bin/perl

use strict;

# This script creats quagga config files for
# new routing instance.


my $daemon = $ARGV[0];

my @list;
if (defined ($daemon)) {
    @list = `/usr/bin/vtysh -d $daemon -c "show running-config"`;
} else {
    @list = `/usr/bin/vtysh -c "show running-config"`;
}


print "!\n";

for (my $n = 0; $n < @list; $n++) {

    if ($list[$n] =~ m/^(ip prefix-list|ipv6 prefix-list|access-list|ipv6 access-list|ip as-path|ip community-list|ip forwarding|ipv6 forwarding)/) {
	print $list[$n];
	my $prefix = $&;
	if ($list[$n+1] =~ /$prefix/) {
	    $n++;
	    while ($list[$n] =~ /^$prefix/) {
		print $list[$n++];
	    }
	    $n--;
	}
	print "!\n";
	
    } elsif ($list[$n] =~ /^route-map/) {
	print $list[$n];
	$n++;
	while ($list[$n] =~ /^\s+/) {
	    print $list[$n++];
	}
	print "!\n";
    }
}


print "!\n";
