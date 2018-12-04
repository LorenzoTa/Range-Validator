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