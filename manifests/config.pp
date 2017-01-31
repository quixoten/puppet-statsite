# Manage statsite configuration
class statsite::config {

  # Parameters for templates
  $binary_stream  = $statsite::binary_stream
  $bind_address   = $statsite::bind_address
  $config_file    = $statsite::config_file
  $daemonize      = $statsite::daemonize
  $flush_interval = $statsite::flush_interval
  $group          = $statsite::group
  $group_ensure   = $statsite::group_ensure
  $histograms     = $statsite::histograms
  $input_counter  = $statsite::input_counter
  $install_path   = $statsite::install_path
  $log_level      = $statsite::log_level
  $manage_group   = $statsite::manage_group
  $manage_user    = $statsite::manage_user
  $parse_stdin    = $statsite::parse_stdin
  $pid_file       = $statsite::pid_file
  $set_eps        = $statsite::set_eps
  $tcp_port       = $statsite::tcp_port
  $timer_eps      = $statsite::timer_eps
  $udp_port       = $statsite::udp_port
  $user           = $statsite::user
  $user_ensure    = $statsite::user_ensure

  if $manage_group {
    group { $group:
      ensure => $group_ensure,
    }
  }

  if $manage_user {
    user { $user:
      ensure => $user_ensure,
    }
  }

  if $statsite::stream_cmd {
    $stream_cmd = $statsite::stream_cmd
  } else {
    $stream_cmd = join([
      "python '${install_path}/current/sinks/graphite.py'",
      "'${statsite::graphite_host}'",
      $statsite::graphite_port,
      "'${statsite::graphite_prefix}'",
      $statsite::graphite_attempts
    ], ' ')
  }

  file { $statsite::config_path:
    ensure => directory,
    mode   => '0644',
  }

  file { $statsite::config_file:
    ensure  => present,
    content => template('statsite/config.erb'),
    mode    => '0644',
  }

  $start_file = $statsite::init_style ? {
    'debian'  => '/etc/init.d/statsite',
    'upstart' => '/etc/init/statsite.conf',
    'systemd' => '/lib/systemd/system/statsite.service',
  }

  file { $start_file:
    ensure  => present,
    content => template("statsite/${statsite::init_style}.erb"),
    mode    => '0755',
  }

}
