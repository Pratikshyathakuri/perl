#!/usr/bin/perl
use strict;
use warnings;
use Getopt::Long;

#Initializing varibales
my $filename = '';
my $pid = '';

#getOpt method to get the user command
GetOptions("filename=s" => \$filename,
           "pid=s" => \$pid);

#creating variable to store the name of the outfile 
my $outFileName = ('out' . $pid . '.txt');   

#opening file for reading
open(my $fh, "<", $filename) 
or "Error Opening the File";

#opening file for writing
open (my $fh2, ">", $outFileName) 
or die "Error Opening the File";

my $numLine = 0;
#using while loop to iterate through the file
while (my $line = <$fh>){
    $numLine++;
     my $toWrite;
    if($line){
         $toWrite = 'Child['. $pid .']: Line['. $numLine .']: '.  $line ;
    }
  
    print $fh2 $toWrite;
}
#closing the files
close $fh; 
close $fh2;
exit;