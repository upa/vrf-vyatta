#!/usr/bin/perl
#
# Module: vtyshow.pl
# 
# **** License ****
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License version 2 as
# published by the Free Software Foundation.
# 
# This program is distributed in the hope that it will be useful, but
# WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
# General Public License for more details.
# 
# This code was originally developed by Vyatta, Inc.
# Portions created by Vyatta are Copyright (C) 2007 Vyatta, Inc.
# All Rights Reserved.
# 
# Author: Stephen Hemminger
# Date: May 2008
# Description: Script to display quagga information
# 
# **** End License ****
#

use strict;
use warnings;

if ($ARGV[0] ne 'show' ) { die "must be a show command\n" };
if ($ARGV[1] ne 'vrf' ) { die "must be a routing-instance command\n" };

my $ns = $ARGV[2];
splice (@ARGV, 1, 1);
splice (@ARGV, 1, 1);


# Substitute in argumentlist to keep show commands simple
my $p = join(' ', @ARGV);
# Vyatta CLI use ospfv3, Quagga use ospf6, modify
$p =~ s/ospfv3/ospf6/g; 
# Quagga use * to denote any, Not possible in Vyatta CLI 
$p =~ s/ any/ */g;

my $n = "/var/run/quagga-" . $ns;

exec 'sudo', '/usr/local/bin/vtysh', '-x', $n, '-c', $p;
die "Could not exec vtysh";


