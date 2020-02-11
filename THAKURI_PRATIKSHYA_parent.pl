#!/usr/bin/perl
use strict;   
use warnings;

open(my $fh, "<", "in.txt") 
or die "Cannot open the file";

my @fileNames;
my $noOfChildren;
my $line;
foreach $line (<$fh>){
  chomp $line;
  my @words = split(" ", $line);

  if($words[0] == 't' || $words[0] == 'T'){
     $noOfChildren = $word[1];
  }
  else{
    @filenames = $words;
  }
}

close $fh;

for (my $i = 1; $i <= $noOfChildren; $i++){
  my $pid = fork();
  if($pid == 0){
    exec('./THAKURI_PRATIKSHYA_child -pid ' . ($i - 1) .' -filename '. $filenames[$i]);
 }
   wait();
}

for(my $k = 1; $k < 100; $k++){
  for(my $j = 0; $j < $noOfChildren; $j++){

    open(my $outChild , "<", 'out'. ($j).'.txt') 
    or die "Error Opening the File";

    open(my $outFinal , ">>", 'out.txt')
    or die "Error Opening the File";

    my $numLine = 0;
    foreach $line (<$outChild>){
      $numLine++;
      if($numLine == $k){
        chomp $line;
        print $outFinal $line;
      }
    }
      close $outFinal;
      close $outChild;
  }
}

print('Finished!');
exit;
