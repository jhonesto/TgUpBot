package upload;

use strict;
use warnings;
use Exporter qw(import);

use subs qw( send_photo read_file send_file );

our @EXPORT_OK = qw( send_telegram );

sub send_telegram { 

  my $file    = $_[0];
  my $chat_id = $_[1];
  my $token   = $_[2];
  my $ipv4    = $_[3];
  my $socks5  = $_[4];
  
  my $markdownfile = $file;
  $markdownfile =~ s/.pdf$/.md/g;
  
  my $picture = $file;
  $picture =~ s/.pdf$/.png/g;
  
  my $caption = read_file($markdownfile);
  
  send_photo( $caption, $picture, $chat_id, $token, $ipv4, $socks5 ) or die "Cannot sent this picture!";
  send_file($file, $chat_id, $token, $ipv4, $socks5 ) or die "Cannot sent this file!";

}


######################### subs #########################

sub send_photo {
    my $message = $_[0];
    my $photo   = $_[1];
    my $chat_id = $_[2];
    my $token   = $_[3];
    my $ipv4    = $_[4];
    my $socks5  = $_[5];

    if(defined($ipv4)) {
    	$ipv4="--ipv4"
    } else {
    	$ipv4="";
    }

    if(defined($socks5)){
    	$socks5="--socks5 " . $socks5;
    } else {
    	$socks5="";
    }

	my $check = `sh -c 'curl $ipv4 $socks5 -F "photo=\@$photo" -F "chat_id=-100$chat_id" -F "caption=$message" -F "parse_mode=MarkdownV2" --url https://api.telegram.org/bot$token/sendPhoto'`;
	return $check;
}

sub read_file {
  my $filename = $_[0];
  my $text = "";

  open(FNAME,'<',$filename) || die "Couldn't open/create a file $filename.";

  while(<FNAME>){
    $text .= $_;
  }

  close(FNAME);
  
  return $text;
}

sub send_file {
    my $document = $_[0];
    my $chat_id  = $_[1];
    my $token    = $_[2];
    my $ipv4     = $_[3];
    my $socks5   = $_[4];

    if(defined($ipv4)) {
    	$ipv4="--ipv4"
    } else {
    	$ipv4="";
    }

    if(defined($socks5)){
    	$socks5="--socks5 " . $socks5;
    } else {
    	$socks5="";
    }
    
	my $check = `sh -c 'curl $ipv4 $socks5 -F "document=\@$document" -F "chat_id=-100$chat_id" --url https://api.telegram.org/bot$token/sendDocument'`;
	return $check;
}

1;
