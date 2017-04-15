use strict;
use ExtUtils::MakeMaker;
WriteMakefile(
  NAME          => 'Filter::Simple',
  VERSION_FROM  => 'lib/Filter/Simple.pm',
  INSTALLDIRS   => 'perl',
  'LICENSE'     => 'perl',
  'INSTALLDIRS' => 'perl',
  ($] >= 5.005 ?
  (ABSTRACT_FROM => 'lib/Filter/Simple.pm',
   'AUTHOR'      => 'Damian Conway') : ()),
  PREREQ_PM     => {
    'parent'    => 0, # needed for the tests on 5.8.x only, otherwise core anyway
    'Text::Balanced' => '1.97',
    'Filter::Util::Call' => 0
  },
);
