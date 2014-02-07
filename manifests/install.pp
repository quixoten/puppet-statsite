# Install statsite
class statsite::install inherits statsite {

  $package      = "v${statsite::version}.tar.gz"
  $version_path = "${statsite::install_path}/statsite-${statsite::version}"

  ensure_packages(['scons', 'build-essential'])

  Exec {
    cwd  => $statsite::install_path,
    path => ['/usr/bin', '/bin'],
  }

  file { $statsite::install_path:
    ensure => directory,
  } ->
  exec { 'statsite::install::download':
    command => "curl -LO https://github.com/armon/statsite/archive/${package}",
    unless  => "test -d ${version_path}",
    creates => "${statsite::install_path}/${package}",
  } ~>
  exec { 'statsite::install::extract':
    command => "tar axf ${package}",
    creates => $version_path,
  } ~>
  exec { 'statsite::install::compile':
    cwd     => $version_path,
    command => 'make',
    creates => "${version_path}/statsite",
  }

  file { "${statsite::install_path}/current":
    ensure  => link,
    target  => $version_path,
    require => Exec['statsite::install::compile'],
  }
}
