# OS specific parameters
class statsite::params {
  case $::osfamily {
    'Debian' : {
      $packages   = ['scons', 'build-essential']
      $init_style = 'debian'
      $user       = 'www-data'
      $group      = 'www-data'

      if ($::operatingsystem == 'Ubuntu') {
        if versioncmp($::operatingsystemrelease, '15.04') >= 0 {
          $init_style = 'systemd'
        } else {
          $init_style = 'debian'
        }
      }
    }

    'RedHat': {
      $packages   = ['scons', 'make', 'gcc-c++']

      if    ($::operatingsystem != 'Fedora' and versioncmp($::operatingsystemrelease, '7') >= 0)
         or ($::operatingsystem == 'Fedora' and versioncmp($::operatingsystemrelease, '15') >= 0)

        $init_style = 'systemd'
        $user       = 'root'
        $group      = 'root'
      } else {
        fail("${::osfamily}/${::operatingsystemrelease} is not currently supported.")
      }
    }

    default: {
      fail("${::osfamily} is not currently supported.")
    }
  }
}
