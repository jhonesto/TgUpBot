package metadata;

use strict;
use warnings;
use Exporter qw(import);

our @EXPORT_OK = qw( remove_metadata extract_metadata );


sub remove_metadata {
	my $check = `sh -c 'command  exiftool -all= -overwrite_original $_[0]'`;
	return $check;
}

sub extract_metadata {
  my $book = $_[0];
  my $opf  = $_[0];
 
  $book =~ s/_/ /g;
  $book =~ s/.pdf//g;
  $opf =~ s/.pdf//g;
  my $check = `sh -c 'command fetch-ebook-metadata -t "$book" -c "$opf.png" -o meta.opf > "$opf".opf'`;
  return $check;
}

1;
