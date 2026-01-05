#!/usr/bin/env perl
# fzf preview script for Ghostty themes

use strict;
use warnings;

my $theme = $ARGV[0] or die "Usage: $0 <theme-name>\n";
my $themes_dir = "/Applications/Ghostty.app/Contents/Resources/ghostty/themes";

# Check Linux paths
if (!-d $themes_dir) {
    if (-d "/usr/share/ghostty/themes") {
        $themes_dir = "/usr/share/ghostty/themes";
    } elsif (-d "/usr/local/share/ghostty/themes") {
        $themes_dir = "/usr/local/share/ghostty/themes";
    }
}

my $theme_file = "$themes_dir/$theme";

if (!-f $theme_file) {
    print "Theme not found: $theme\n";
    exit 1;
}

# Read palette colors (0-15)
my @colors;
my $bg = "#1a1b26";
my $fg = "#c0caf5";

open(my $fh, '<', $theme_file) or die "Cannot open $theme_file: $!";
while (my $line = <$fh>) {
    if ($line =~ /^palette = (\d+)=#([0-9a-fA-F]{6})/) {
        $colors[$1] = $2;
    } elsif ($line =~ /^background = #([0-9a-fA-F]{6})/) {
        $bg = $1;
    } elsif ($line =~ /^foreground = #([0-9a-fA-F]{6})/) {
        $fg = $1;
    }
}
close($fh);

# RGB to 256-color conversion
sub rgb_to_256 {
    my ($r, $g, $b) = @_;
    if ($r == $g && $g == $b) {
        return 16 if $r < 8;
        return 231 if $r > 248;
        return int(($r - 8) / 10) + 232;
    }
    my $ir = int(($r - 35) / 40);
    my $ig = int(($g - 35) / 40);
    my $ib = int(($b - 35) / 40);
    $ir = 0 if $ir < 0; $ir = 5 if $ir > 5;
    $ig = 0 if $ig < 0; $ig = 5 if $ig > 5;
    $ib = 0 if $ib < 0; $ib = 5 if $ib > 5;
    return 16 + $ir * 36 + $ig * 6 + $ib;
}

sub to_256 {
    my ($hex) = @_;
    my ($r, $g, $b) = map { hex } ($hex =~ /(..)(..)(..)/);
    return rgb_to_256($r, $g, $b);
}

my $bg_c = to_256($bg);
my $fg_c = to_256($fg);
my @c;
for my $i (0..7) {
    $c[$i] = defined($colors[$i]) ? to_256($colors[$i]) : 0;
}

# Print theme header
printf "\033[48;5;%dm\033[38;5;%dm  %s  \033[0m\n", $bg_c, $fg_c, $theme;
print "\n";

# Print Colors section
print "\033[1mColors:\033[0m\n";
printf "  \033[48;5;%dm   \033[0m blk ", $c[0];
printf "\033[48;5;%dm   \033[0m red ", $c[1];
printf "\033[48;5;%dm   \033[0m grn ", $c[2];
printf "\033[48;5;%dm   \033[0m yel ", $c[3];
printf "\033[48;5;%dm   \033[0m blu ", $c[4];
printf "\033[48;5;%dm   \033[0m mag ", $c[5];
printf "\033[48;5;%dm   \033[0m cyn ", $c[6];
printf "\033[48;5;%dm   \033[0m wht\n", $c[7];
print "\n";

# Print Sample section
print "\033[1mSample:\033[0m\n";
printf "\033[38;5;%dm# Comment\033[0m\n", $c[0];
printf "\033[38;5;%dmfunction\033[38;5;%dm \033[38;5;%dmhello\033[38;5;%dm()\033[38;5;%dm {\033[0m\n", $c[2], $c[7], $c[4], $c[3];
printf "  \033[38;5;%dm\033[38;5;%decho\033[38;5;%dm \"\033[38;5;%dmHello\033[38;5;%dm\"\033[0m\n", $c[0], $c[6], $c[7], $c[3], $c[7];
printf "\033[38;5;%dm}\033[0m\n", $c[3];
