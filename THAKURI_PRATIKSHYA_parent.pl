#!/usr/bin/perl
use strict;   
use warnings;

open(my $fh, "<", "in.txt") 
or die "Cannot open the file";

my @filenames;
my $noOfChildren;
my $line;
foreach $line (<$fh>){
  chomp $line;
  my @words = split(" ", $line);

  if($words[0] eq 't' || $words[0] eq 'T'){
     $noOfChildren = $words[1];
  }
  else{
    @filenames = @words;
  }
}

print $noOfChildren;

close $fh;

for (my $i = 1; $i <= $noOfChildren; $i++){
  my $pid = fork();
  if($pid == 0){
    print($filenames[$i]);
    exec('./THAKURI_PRATIKSHYA_child.pl -filename ' . $filenames[$i]. ' -pid ' .($i - 1) );
 }
   wait();
}

for(my $k = 1; $k < 100; $k++){
  for(my $j = 0; $j < $noOfChildren; $j++){

    open(my $fh2 , "<", 'out'. ($j).'.txt') 
    or die "Error Opening the File";

    open(my $fh3, ">>", 'out.txt')
    or die "Error Opening the File";

    my $numLine = 0;
     $line = '';
    foreach $line (<$fh2>){
      $numLine++;
      if($numLine == $k){
        chomp $line;
        print $fh3 $line . "\n";
      }
    }
      close $fh2;
      close $fh3;
  }
}

print('Finished!');
exit;
