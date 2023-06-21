package files;

use strict;
use warnings;
use Exporter qw(import);

our @EXPORT_OK = qw( get_file_list move_files create_dir );

sub get_file_list {
  chdir $_[0];
  my @files =  glob("*.$_[1]");
  return @files;
}

sub move_files {
  my $dir = $_[0];
  $dir =~ s/.pdf//g;
  my $check = `sh -c 'command  mv -f $dir.* $dir/'`;
  return $check;
}

sub create_dir {
  my $dir = $_[0];
  $dir =~ s/.pdf//g;
  if (-e $dir and -d $dir) {
  	print "Directory $dir already exists!\n";
  } else {
  	mkdir( $dir ) or die "Couldn't create $dir directory, $!";
  }
}

1;

