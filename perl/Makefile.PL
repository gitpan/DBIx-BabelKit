
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME		=> 'DBIx::BabelKit',
    VERSION_FROM	=> 'BabelKit.pm',
    PREREQ_PM		=> { DBI => 0 },
    ABSTRACT_FROM       => 'BabelKit.pm',
    AUTHOR              => 'John Gorman <jgorman@webbysoft.com>',
    PM                  => { 'BabelKit.pm' => '$(INST_LIBDIR)/BabelKit.pm' }
);
