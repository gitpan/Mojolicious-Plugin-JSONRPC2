use 5.010001;
use strict;
use warnings;
use Module::Build;

my $class = Module::Build->subclass(
    class => 'Module::Build::Custom',
    code => <<'SUBCLASS' );

# Better compatibility with Gentoo ebuilds.
sub dist_version {
    my $self = shift;
    my $v = $self->SUPER::dist_version;
    $v =~ s/\Av//ms;
    return $v;
}
SUBCLASS

my $builder = $class->new(
    module_name         => 'Mojolicious::Plugin::JSONRPC2',
    license             => 'mit',
    dist_author         => 'Alex Efros <powerman@cpan.org>',
    dist_version_from   => 'lib/Mojolicious/Plugin/JSONRPC2.pm',
    release_status      => 'stable',
    configure_requires => {
        'Module::Build'         => 0.4004, # for test_requires
    },
    requires => {
        'perl'                  => 5.010001,
        'version'               => '0.77',
        'Mojolicious'           => 5.11,
        'JSON::XS'              => 0,
        'JSON::RPC2'            => '0.4.0',
    },
    test_requires => {
        'Test::More'            => 0,
        'Test::Exception'       => 0,
        'Test::CheckManifest'   => '0.9',
        'Test::Perl::Critic'    => 0,
        'Test::Pod'             => '1.22',
        'Test::Pod::Coverage'   => '1.08',
        'Pod::Coverage'         => '0.18',
    },
#     add_to_cleanup     => [ 'Mojolicious-Plugin-JSONRPC2-*' ],
);

$builder->create_build_script();
