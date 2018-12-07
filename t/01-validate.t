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

foreach my $reversed ('3..1,7..9','1..4,7..5','3..4, 7..5','0..2,27..5'){
	dies_ok { Range::Validator::validate( $reversed ) } "expected to die with reverse range [$reversed]";
}

my %test = (
	'1,1..3'	=> [(1,2,3)],
	'1,2..5,4'	=> [(1,2,3,4,5)],
	'1..5,3'	=> [(1,2,3,4,5)],
	'8,9,1..2'	=> [(1,2,8,9)],
	'1..3,3,5..7'	=> [(1,2,3,5,6,7)],
	'5..7,1..6'		=> [(1,2,3,4,5,6,7)],
	'0..5,3'		=> [(0,1,2,3,4,5)]
);

# ranges, even if overlapped or unordered, return the correct array
foreach my $range ( keys %test ){
	my @res = Range::Validator::validate($range);
	is_deeply( $test{$range},\@res,
				"correct result for range [$range]"
	);
}
