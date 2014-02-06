class statsite::install inherits statsite {

  $package      = "v$statsite::version.tar.gz"
  $version_path = "$statsite::install_path/v$statsite::version"

  ensure_packages(['scons'])

  Exec {
    cwd  => $statsite::install_path,
    path => ['/usr/bin', '/bin'],
  }

  file { $statsite::install_path:
    ensure => directory,
  } ->
  exec { 'statsite::install:download':
    command => "curl -LO https://github.com/armon/statsite/archive/$package",
    onlyif  => "! test -d $version_path",
    creates => $package,
  } ~>
  exec { 'statsite::install::extract':
    command => "tar axf $package",
    creates => $version_path,
  } ~>
  exec { "statsite::install::compile":
    cwd     => $version_path,
    command => "make",
    creates => "$version_path/statsite",
  }

  file { "$install_path/bin/statsite":
    ensure  => link,
    source  => "$version_path/v$statsite::version/statsite",
    require => Exec['statsite::install::compile'],
  }

  file { "$install_path/sinks":
    ensure  => link,
    source  => "$statsite::install_path/v$statsite::version/sinks",
    require => Exec['statsite::install::compile'],
  }
}
