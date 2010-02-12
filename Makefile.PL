use inc::Module::Install;

name 'MooseX-Types-Varchar';
all_from 'lib/MooseX/Types/Varchar.pm';

test_requires 'Test::NoTabs';
requires 'Moose';
requires 'MooseX::Types';

auto_install;
WriteAll;
