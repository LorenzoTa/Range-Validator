use 5.006;
use strict;
use warnings;
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME             => 'Range::Validator',
    AUTHOR           => q{MyName <MyName@cpan.org>},
    VERSION_FROM     => 'lib/Range/Validator.pm',
    ABSTRACT_FROM    => 'lib/Range/Validator.pm',
    LICENSE          => 'artistic_2',
    PL_FILES         => {},
    MIN_PERL_VERSION => '5.006',
    CONFIGURE_REQUIRES => {
        'ExtUtils::MakeMaker' => '0',
    },
    BUILD_REQUIRES => {
        'Test::More' 		=> '0',
		'Test::Exception' 	=> '0',
		'Capture::Tiny'   	=> '0',
    },
    PREREQ_PM => {
        'Carp'	=> '0',
    },
    dist  => { COMPRESS => 'gzip -9f', SUFFIX => 'gz', },
    clean => { FILES => 'Range-Validator-*' },
);
