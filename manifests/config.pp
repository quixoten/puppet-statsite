class statsite::config inherits statsite {
  $tcp_port = $statsite::tcp_port
  $udp_port = $statsite::udp_port
  $bind_address = $statsite::bind_address
  $parse_stdin = $statsite::parse_stdin
  $log_level = $statsite::log_level
  $flush_interval = $statsite::flush_interval
  $timer_eps = $statsite::timer_eps
  $set_eps = $statsite::set_eps
  $stream_cmd = $statsite::stream_cmd
  $input_counter = $statsite::input_counter
  $pid_file = $statsite::pid_file
  $binary_stream = $statsite::binary_stream
  $histograms = $statsite::histograms

  file { "$statsite::config_file":
    ensure => present,
    source => template('statsite/config.erb'),
  }
}
