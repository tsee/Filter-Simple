use strict;
use ExtUtils::MakeMaker;
# Normalize version strings like 6.30_02 to 6.3002,
# so that we can do numerical comparisons on it.
my $eumm_version = $ExtUtils::MakeMaker::VERSION;
$eumm_version =~ s/_//;

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
  ($eumm_version >= 6.46 ?
    (META_MERGE => {
      "meta-spec" => { version => 2 },
      resources => {
        repository => {
          web => 'https://github.com/tsee/Filter-Simple',
          url => 'git://github.com/tsee/Filter-Simple.git',
          type => 'git',
        }
      },
      dynamic_config   => 0, # we promise to keep META.* up-to-date
      x_static_install => 1, # we are pure Perl and don't do anything fancy
    }) : ()),
);
