# OS specific parameters
class statsite::params {
  case $::operatingsystem {
    'Debian' : {
      $packages   = ['scons', 'build-essential']
      $init_style = 'debian'
      $user       = 'www-data'
      $group      = 'www-data'
    }

    'Ubuntu': {
      $packages   = ['scons', 'build-essential']
      $user       = 'www-data'
      $group      = 'www-data'

      if versioncmp($::operatingsystemrelease, '15.04') >= 0 {
        $init_style = 'systemd'
      } else {
        $init_style = 'upstart'
      }
    }

    'Fedora': {
      $packages   = ['scons', 'make', 'gcc-c++']

      if versioncmp($::operatingsystemrelease, '15') >= 0 {
        $init_style = 'systemd'
        $user       = 'root'
        $group      = 'root'
      } else {
        fail("${::operatingsystemrelease} is not currently supported.")
      }
    }

    'CentOS': {
      $packages   = ['scons', 'make', 'gcc-c++']

      if versioncmp($::operatingsystemrelease, '7') >= 0 {
        $init_style = 'systemd'
        $user       = 'root'
        $group      = 'root'
      } else {
        fail("${::operatingsystemrelease} is not currently supported.")
      }
    }

    default: {
      fail("${::osfamily} is not currently supported.")
    }
  }
}
