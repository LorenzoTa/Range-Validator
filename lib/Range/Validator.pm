package Range::Validator;

use 5.006;
use strict;
use warnings;

use Carp;

our $VERSION = '0.01';
our $WARNINGS = 0;

sub validate{
	my $range;
	my @range;
	# assume we have a string if we receive only one argument
	if ( @_ == 1){
		$range = $_[0];
		# remove any space from string
		$range =~ s/\s+//g;
		# die if invalid characters
		croak "invalid character passed in string [$range]!" 
				if $range =~ /[^\s,.\d]/;
		# not allowed a lone .
		croak "invalid range [$range] (single .)!" if $range =~ /(?<!\.)\.(?!\.)/; 
		# not allowed more than 2 .
		croak "invalid range [$range] (more than 2 .)!" if $range =~ /\.{3}/;
		# spot reverse ranges like 27..5
		if ($range =~ /[^.]\.\.[^.]/){
			foreach my $match ( $range=~/(\d+\.\.\d+)/g ){
				$match=~/(\d+)\.\.(\d+)/;
				croak "$1 > $2 in range [$range]" if $1 > $2;
			}
		}
		# eval the range
		@range = eval ($range);
	}
	elsif ( $WARNINGS == 1 and @_ == 0 ){
		carp "Empty list passed in! We assume all element will be processed.";
	}
	# otherwise we received a list
	else{
		@range = @_;
	}	
	# remove duplicate elements using a hash
	my %single = map{ $_ => 1} @range;
	# sort unique keys numerically
	@range = sort{ $a <=> $b } keys %single;
	return @range;
}

1;

__DATA__

=head1 NAME

Range::Validator - a simple module to verify array and list ranges

=head1 VERSION

Version 0.01

=cut

=head1 SYNOPSIS

    use Range::Validator;

    my @range = Range::Validator->validate(0..3);      # a valid range
	
    my @range = Range::Validator->validate(0..3,2);    # a overlapping range
	
    my @range = Range::Validator->validate('1,3,7');   # a valid range passed as a string
    
    my @range = Range::Validator->validate('1,XXX,3'); # an invalid range  passed as a string
	


=head1 SUBROUTINES

=head2 validate

This function accepts a string or a list (range) and returns an array.
In the string form the accepted charachters are: positive integers, dots, commas and spaces. Every space will be removed.

Every string with occurences of a lone dot or more than two dots will be rejected causing an exception in the calling program.

Reverse ranges like in C<'3..1'> passed as string will also cause an exception.

In both string and list form any duplicate element (overlapped range) will be silently removed. Any form of unordered list will be silently rerodered.


=head1 ENABLE WARNINGS

If the C<$Range::Validator::WARNINGS> is set to a true value then an empty list passed to C<validate> will provoke a warning from the caller perspective.


=head1 AUTHOR

MyName, C<< <MyName at cpan.org> >>

=head1 BUGS

Please report any bugs or feature requests to C<bug-range-validator at rt.cpan.org>, or through
the web interface at L<https://rt.cpan.org/NoAuth/ReportBug.html?Queue=Range-Validator>.  I will be notified, and then you'll
automatically be notified of progress on your bug as I make changes.


=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc Range::Validator


You can also look for information at:

=over 4

=item * RT: CPAN's request tracker (report bugs here)

L<https://rt.cpan.org/NoAuth/Bugs.html?Dist=Range-Validator>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/Range-Validator>

=item * CPAN Ratings

L<https://cpanratings.perl.org/d/Range-Validator>

=item * Search CPAN

L<https://metacpan.org/release/Range-Validator>

=back


=head1 ACKNOWLEDGEMENTS


=head1 LICENSE AND COPYRIGHT

Copyright 2018 MyName.

This program is free software; you can redistribute it and/or modify it
under the terms of the the Artistic License (2.0). You may obtain a
copy of the full license at:

L<http://www.perlfoundation.org/artistic_license_2_0>

Any use, modification, and distribution of the Standard or Modified
Versions is governed by this Artistic License. By using, modifying or
distributing the Package, you accept this license. Do not use, modify,
or distribute the Package, if you do not accept this license.

If your Modified Version has been derived from a Modified Version made
by someone other than you, you are nevertheless required to ensure that
your Modified Version complies with the requirements of this license.

This license does not grant you the right to use any trademark, service
mark, tradename, or logo of the Copyright Holder.

This license includes the non-exclusive, worldwide, free-of-charge
patent license to make, have made, use, offer to sell, sell, import and
otherwise transfer the Package with respect to any patent claims
licensable by the Copyright Holder that are necessarily infringed by the
Package. If you institute patent litigation (including a cross-claim or
counterclaim) against any party alleging that the Package constitutes
direct or contributory patent infringement, then this Artistic License
to you shall terminate on the date that such litigation is filed.

Disclaimer of Warranty: THE PACKAGE IS PROVIDED BY THE COPYRIGHT HOLDER
AND CONTRIBUTORS "AS IS' AND WITHOUT ANY EXPRESS OR IMPLIED WARRANTIES.
THE IMPLIED WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR
PURPOSE, OR NON-INFRINGEMENT ARE DISCLAIMED TO THE EXTENT PERMITTED BY
YOUR LOCAL LAW. UNLESS REQUIRED BY LAW, NO COPYRIGHT HOLDER OR
CONTRIBUTOR WILL BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, OR
CONSEQUENTIAL DAMAGES ARISING IN ANY WAY OUT OF THE USE OF THE PACKAGE,
EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.


=cut

1; # End of Range::Validator
