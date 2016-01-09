#!/bin/perl

#use File::Basename;
use Encode;
use XML::Simple;

my $filenameIn = $ARGV[0];
my $filename = $filenameIn;
$filename =~ s/\..+$//;
my $filenameOut = $filename . ".nfo";

# open xml file
 my $ref = XMLin($filenameIn , ForceArray => 1);

my $title;
my $plot;
my $genre;
my $episodeNum;
my $startTime;
 
for my $simpletag ($ref->{tag}{SimpleTag})
{
  if ($simpletag->{name} eq "EPISODENAME")
  {
    $title = $simpletag->{value};
  }
  if ($simpletag->{name} eq "COMMENT")
  {
    $plot = $simpletag->{value};
  }
  if ($simpletag->{name} eq "GENRE")
  {
    $genre = $simpletag->{value};
  }
  if ($simpletag->{name} eq "EPISODENUM")
  {
    $episodeNum = $simpletag->{value};
  }
}
 
open (FILENAMEOUT, ">$filenameOut");
binmode(FILENAMEOUT, ":utf8");

print FILENAMEOUT "<episodedetails>\n";
print FILENAMEOUT "  <title>$title</title>\n";
print FILENAMEOUT "  <id></id>\n";
print FILENAMEOUT "  <rating></rating>\n";
print FILENAMEOUT "  <season>$season</season>\n";
print FILENAMEOUT "  <episode>$episode</episode>\n";
print FILENAMEOUT "  <plot>$plot</plot>\n";
print FILENAMEOUT "  <runtime></runtime>\n";
print FILENAMEOUT "  <aired></aired>\n";
print FILENAMEOUT"</episodedetails>\n";