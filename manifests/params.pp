# OS specific parameters

class statsite::params {
  $user  = 'nobody'
  $group = 'nobody'

  case $::operatingsystem {
    'Debian' : {
      $packages      = ['scons', 'build-essential']
      $init_file     = '/etc/init.d/statsite'
      $init_template = 'statsite/initd.debian.erb'
      $daemonize     = 0
      $pid_file      = '/var/run/statsite.pid'
    }

    'Ubuntu': {
      $packages  = ['scons', 'build-essential']
      $daemonize = 0
      $pid_file  = '/var/run/statsite.pid'

      if versioncmp($::operatingsystemrelease, '15.04') >= 0 {
        $init_file     = '/lib/systemd/system/statsite.service'
        $init_template = 'statsite/systemd.erb'
      } else {
        $init_file     = '/etc/init/statsite.conf'
        $init_template = 'statsite/upstart.erb'
      }
    }

    'Fedora': {
      $packages  = ['scons', 'make', 'gcc-c++']
      $daemonize = 0
      $pid_file  = '/var/run/statsite.pid'

      if versioncmp($::operatingsystemrelease, '25') >= 0 {
        $init_file     = '/lib/systemd/system/statsite.service'
        $init_template = 'statsite/systemd.erb'
      } else {
        fail("${::operatingsystem}/${::operatingsystemrelease} is not currently supported.")
      }
    }

    'CentOS': {
      $packages = ['scons', 'make', 'gcc-c++']

      if versioncmp($::operatingsystemrelease, '7') >= 0 {
        $init_file     = '/lib/systemd/system/statsite.service'
        $init_template = 'statsite/systemd.erb'
        $daemonize     = 0
        $pid_file      = '/var/run/statsite.pid'
      } elsif versioncmp($::operatingsystemrelease, '6') >= 0 {
        $init_file     = '/etc/init.d/statsite'
        $init_template = 'statsite/initd.centos.erb'
        $daemonize     = 1
        $pid_file      = '/var/run/statsite/statsite.pid'
      } else {
        fail("${::operatingsystem}/${::operatingsystemrelease} is not currently supported.")
      }
    }

    default: {
      fail("${::operatingsystem}/${::operatingsystemrelease} is not currently supported.")
    }
  }
}
