package check_list;

use strict;
use warnings;
use Exporter qw(import);

our @EXPORT_OK = qw( check_command check_files check_directory );

sub check_command { 
  my $check = `sh -c 'command -v $_[0]'`;
  return $check;
}

sub check_directory {
  my $b = -d $_[0];
  return $b;
}

sub check_files {
  chdir $_[0] or die "Cannot chdir to $_[0]!\n";
  my @myfiles = glob("*.$_[1]");
  my $cnt = @myfiles;
  return $cnt;
}

1;
