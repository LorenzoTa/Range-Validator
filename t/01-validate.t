#!perl
use 5.006;
use strict;
use warnings;
use Test::More qw(no_plan);
use Test::Exception;

use_ok( 'Range::Validator' ); 

ok (scalar Range::Validator::validate('0..2') == 3, 
	'ok valid string produces correct number of elements' );

note ("starting test of forbidden characters in the string form");

dies_ok { Range::Validator::validate('xxxinvalidstringxxx') }
			"expected to die with invalid character";
			
note ("start checks about incorrect dots in string");

foreach my $string ( '1.2', '0..2,5.6,8', '1,2,.,3', '.', '1.', '.1' ){
	dies_ok { Range::Validator::validate( $string ) }
			"expected to die with a lone dot in range [$string]";
}

foreach my $newstring ( '1...3', '1,3...5','...', '1...', '...2' ){
	dies_ok { Range::Validator::validate( $newstring ) }
			"expected to die with three dots in range [$newstring]";
}