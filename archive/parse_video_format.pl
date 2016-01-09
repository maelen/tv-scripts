#!/bin/perl

my $filename = $ARGV[0];

open (FILENAME, $filename);
while (<FILENAME>)
{
   if ( /29\.97 tbr/ )
   {
      $deinterlace = "-filter:v yadif,format=yuv420p"
   }
   
   if (  /Stream .+: Video: .+, .+, (\d+)x(\d+) \[SAR (\d+):(\d+) DAR (\d+):(\d+)\]/ )
   {
      $width1         = $1;
      $height1        = $2;
      $PAR[0]         = $3;
      $PAR[1]         = $4;
      $DAR1[0]        = $5;
      $DAR1[1]        = $6;      
   }
}

my $width2;
my $height2;
if ($width1 eq "1920" && $height1 eq "1080")
{
  $width2 = "1280";
  $height2 = "720";
}
else
{
  $width2 = $width1;
  $height2 = $height1;
}
@DAR2 = @DAR1;
# my $width2;
# if ( "@DAR1" eq "4 3")
# {
   # if( ($width1/$height1) < 1.5)
   # {
      # $width2 = 640;
      # @DAR2 = @DAR1;
   # }
   # else
   # {
      # $width2 = 704;
      # @DAR2 = (16,9);
   # }
# }
# elsif ( "@DAR1" eq "16 9")
# {
   # $width2 = 704;
   # @DAR2 = @DAR1;
# }

# my $height2=($DAR1[0]*$PAR[1]*$DAR2[1]*$height1 * $width2) / ($DAR1[1]*$PAR[0]*$DAR2[0]*$width1);
# $height2=int($height2);
print "${width2}x${height2} $DAR2[0]:$DAR2[1] $deinterlace";