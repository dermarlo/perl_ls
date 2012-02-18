#!/usr/bin/perl -w

use strict;
use Cwd;

my $dir;
if(!defined @ARGV) {
	$dir=&Cwd::cwd();
}
else {
	$dir=shift; 
}

my @all;

crawl($dir);

foreach (sort(@all)) {
	print "$_\n";
}

exit 0;

sub crawl {
my $dir=shift;
my ($res,$file,$path);

local *DIR;

unless (opendir(DIR,$dir)) { return; }

while (defined ($file=readdir(DIR))) {
next if ($file =~ /^[\.]{1,2}$/);
$path=$dir."/".$file;

if ( -d $path) {
	$res=$path." [DIR]";
	push(@all,$res);
}
else {
	push(@all,$path);
}
crawl($path) if ( -d $path);
}
closedir(DIR);
return 0;
}
