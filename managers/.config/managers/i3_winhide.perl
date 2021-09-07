#!/usr/bin/perl

# This script, make window in i3 mark with the 'minimized' name but have the suffix 
# numbers based on figures prior to its
# E.g = minimized_1, minimized_2 ... so on
# Source (solution): https://github.com/i3/i3/issues/2192#issuecomment-180517983

use strict;
use Data::Dumper;
use AnyEvent;
use AnyEvent::I3;
my $prefix = 'minimized';
my @n = sort map { /^${prefix}_(\d+)$/ && $1 } @{i3->get_marks->recv};
my $next = ($n[-1] || 0) + 1;
i3->command("mark ${prefix}_${next}, move scratchpad")->recv
