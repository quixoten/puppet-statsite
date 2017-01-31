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

  if $statsite::init_source {
    $init_source  = $statsite::init_source
    $init_content = undef
  } elsif $statsite::init_content {
    $init_source  = undef
    $init_content = $statsite::init_content
  } elsif $statsite::init_template {
    $init_source  = undef
    $init_content = template($statsite::init_template)
  } else {
    fail('One of init_source, init_content, or init_template must be defined.')
  }

  file { $statsite::init_file:
    ensure  => present,
    source  => $init_source,
    content => $init_content,
    mode    => '0755',
  }

}
