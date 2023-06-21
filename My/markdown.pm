package markdown;

use strict;
use Exporter qw(import);
use XML::Simple;
use Data::Dumper;
use warnings;
use subs qw( write2file );

our @EXPORT_OK = qw( create_markdown );

sub create_markdown {

  my $file = $_[0] ;
  $file =~ s/.pdf/.opf/g;
  
  my $markdownfile = $file;
  
  my $title = $file;
  $title =~ s/_/ /g;
  $title =~ s/.opf$//g;
  
  $markdownfile =~ s/.opf$/.md/g;
  
  write2file($markdownfile,"*$title* \n\n");
  
  # create object
  my $xml = XML::Simple->new();
  
  # read XML file
  my $data = $xml->XMLin($file);
  
  # print output
  #print Dumper($data);
  
  my $publisher = $data->{metadata}{'dc:publisher'};  
  
  write2file($markdownfile,"*Publisher: *$publisher \n");
  
  my $creator =  $data->{metadata}{'dc:creator'};
  
  my $auth = "";
  
  if(ref($creator) =~ /HASH/){
    
    my %cont =  %$creator;
    $auth .= "*Author: *";
    $auth .= $cont{'content'};
    
  } elsif (ref($creator) =~ /ARRAY/) {
  
     my $size = scalar @$creator;
     
     if(scalar @$creator == 1){
       $auth .= "*Author: *";
     } else {
   	   $auth .= "*Authors: *";
     }
     
     for (my $i = 0; $i < $size; $i++){
       my $kreator =  (@{$creator}[$i]);
       if(ref($kreator) =~ /HASH/){
         my %cont =  %$kreator;
         my $contentdesc = $cont{'content'};
         $contentdesc =~ s/[^[:alpha:]]/\\$&/g;
         $auth .= $contentdesc;
         #$auth .= $cont{'content'};
         $auth .= ", " unless $i == $size-1;
       }
     }
     
  }
  
  write2file($markdownfile, $auth . " \n");
  
  #print "$auth \n";
  
  my $subjects =  $data->{metadata}{'dc:subject'};
  
  #print "Subjects\n";
  
  my $subject = "";
  
  if(ref($subjects) =~ /ARRAY/){
  
  my $subjs = join("#", @$subjects);
  $subjs = "#" . $subjs;
  $subjs =~ s/ /\\_/g;
  $subjs =~ s/&/And/g;
  $subjs =~ s/#/ #/g;
  $subjs =~ s/-/\\-/g;
  $subjs =~ s/\(/\\(/g;
  $subjs =~ s/\)/\\)/g;

  
  $subjects = $subjs;
  
  }
  
  $subjects .= "";
  $subjects = "*Subjects:*" . $subjects;
  
  write2file($markdownfile, $subjects . "\n");
  	
}


######################### subs #########################


sub write2file  {

	my $filename = shift;
	my $message = shift;

	open(FNAME,'>>',$filename) || die "Couldn't open/create a file $filename.";

	$message =~  s/["']/ /g;
	$message =~  s/[\#|.|-|{|}|[|]|\|]/\\\\$&/g;
	
	print FNAME $message;
	
	close(FNAME);
}


1;
