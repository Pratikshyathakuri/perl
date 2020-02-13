#!/usr/bin/perl
use strict;
use warnings;
use Getopt::Long;

my $filename = '';
my $pid = '';

GetOptions("filename=s" => \$filename,
           "pid=s" => \$pid);

my $outFileName = ('out' . $pid . '.txt');   

open(my $fh, "<", $filename) 
or "Error Opening the File";

open (my $fh2, ">>", $outFileName) 
or die "Error Opening the File";

my $line;
my $numLine = 0;
foreach $line (<$fh>){
    $numLine++;
    chomp $line;
    my $toWrite =  'Child['. $pid .']: Line['. $numLine .']: '.  $line . "\n";
    print $fh2 'Child['. $pid .']: Line['. $numLine .']: '.  $line . "\n";
}

close $fh;
close $fh2;

print('Finished Writing to File: out' . $pid. ".txt\n");
exit 0;