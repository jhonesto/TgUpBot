package figlet;

use strict;
use warnings;
use Exporter qw(import);

our @EXPORT_OK = qw(show_figlet);

sub show_figlet {

  my $file = "./My/FIGLET";
  open(FNAME,'<',$file) || die "Couldn't open a file $file.";
  
  while(<FNAME>){
    print $_;
  }

  close(FNAME);
} 

1;
