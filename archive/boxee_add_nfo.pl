#!/bin/perl

use File::Basename;
use Encode;

my $filenameIn = $ARGV[0];
my $filename = $filenameIn;
$filename =~ s/\.[^.]+$//;
my $filenameOut = $filename . ".nfo";

#print "filename: $filename\n";
#print "filenameOut: $filenameOut\n";

$filename =~ /^.+\s+S(\d+)E(\d+)\s+-*\s*(.+)/;

my $season = $1;
my $episode = $2;
my $title = $3;
$titleTmp = $title;
$title = decode("windows-1252",$titleTmp,Encode::FB_CROAK);

open (FILENAMEOUT, ">$filenameOut");
binmode(FILENAMEOUT, ":utf8");

print FILENAMEOUT "<episodedetails>\n";
print FILENAMEOUT "  <title>$title</title>\n";
print FILENAMEOUT "  <id></id>\n";
print FILENAMEOUT "  <rating></rating>\n";
print FILENAMEOUT "  <season>$season</season>\n";
print FILENAMEOUT "  <episode>$episode</episode>\n";
print FILENAMEOUT "  <plot></plot>\n";
print FILENAMEOUT "  <runtime></runtime>\n";
print FILENAMEOUT "  <aired></aired>\n";
print FILENAMEOUT"</episodedetails>\n";