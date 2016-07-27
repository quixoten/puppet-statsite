# Manage statsite configuration
class statsite::config inherits statsite {

  # Parameters for templates
  $config_file    = $statsite::config_file
  $tcp_port       = $statsite::tcp_port
  $udp_port       = $statsite::udp_port
  $bind_address   = $statsite::bind_address
  $parse_stdin    = $statsite::parse_stdin
  $log_level      = $statsite::log_level
  $flush_interval = $statsite::flush_interval
  $timer_eps      = $statsite::timer_eps
  $set_eps        = $statsite::set_eps
  $input_counter  = $statsite::input_counter
  $pid_file       = $statsite::pid_file
  $binary_stream  = $statsite::binary_stream
  $histograms     = $statsite::histograms

  group { 'statsite':
    ensure  => 'present',
  }
  user { 'statsite':
    ensure  => 'present',
    groups  => 'statsite',
    require => Group['statsite'],
  }

  if $statsite::stream_cmd {
    $stream_cmd = $statsite::stream_cmd
  } else {
    $stream_cmd = join([
      "python '${statsite::install_path}/current/sinks/graphite.py'",
      "'${statsite::graphite_host}'",
      $statsite::graphite_port,
      "'${statsite::graphite_prefix}'",
      $statsite::graphite_attempts
    ], ' ')
  }

  file { $statsite::config_path:
    ensure => directory,
    mode    => '0644',
  }

  file { $statsite::config_file:
    ensure  => present,
    content => template('statsite/config.erb'),
    mode    => '0644',
  }

  $start_file = $init_style ? {
    'debian'  => '/etc/init.d/statsite',
    'upstart' => '/etc/init/statsite.conf',
    'systemd' => '/lib/systemd/system/statsite.service',
  }

  file { $start_file:
    ensure  => present,
    content => template("statsite/${init_style}.erb"),
    mode    => '0755',
  }

}
