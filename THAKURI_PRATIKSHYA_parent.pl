#!/usr/bin/perl
use strict;   
use warnings;

#opening file for reading the number of children and the name of the file
open(my $fh, "<", "in.txt") or die "Cannot open the file";

#variable names
my @filenames;
my $noOfChildren;
my $line;

#loop for iterating through each elements in the file
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

#for loop for creating the child equal to the number in in.txt 
for (my $i = 1; $i <= $noOfChildren; $i++){
  my $pid = fork(); #creating child
  if($pid == 0){
    print($filenames[$i]);
    exec('./THAKURI_PRATIKSHYA_child.pl -filename ' . $filenames[$i]. ' -pid ' .($i - 1) );
 }
   wait();
}

#for loop for iterating through all the files of child process and printing them in out.txt
for(my $k = 1; $k < 200; $k++){
  for(my $j = 0; $j < $noOfChildren; $j++){

    open(my $fh2 , "<", 'out'. ($j).'.txt') 
    or die "Error Opening the File";#opening file for reading

    open(my $fh3, ">>", 'out.txt')
    or die "Error Opening the File"; #opening file for writing

    my $numLine = 0;
     $line = '';
     
     #loop for itrating through each element 
    foreach $line (<$fh2>){
      $numLine++;
      if($numLine == $k){
        chomp $line;
        print $fh3 $line . "\n";
      }
    }
      #closing the files
      close $fh2;
      close $fh3;
  }
}
close $fh;#closing the file

print('Finished!');
exit;
