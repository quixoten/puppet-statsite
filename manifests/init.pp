# == Class: statsite
#
# All in one class for setting up a statsite instance. See README.md for
# more details
#
# === Parameters
#
# [*version*]
#   The version of statsite to install. Defaults to 0.6.0
#
# [*install_path*]
#   The path that statsite will be installed. Defaults to /opt/statsite
#
# [*config_path*]
#   Statsite's configuration directory. Defaults to /etc/statsite
#
# [*tcp_port*]
#   Integer, sets the TCP port to listen on. Default 8125. 0 to disable.
#
# [*udp_port*]
#   Integer, sets the UDP port. Default 8125. 0 to disable.
#
# [*bind_address*]
#   The address to bind on. Defaults to 0.0.0.0
#
# [*parse_stdin*]
#  Enables parsing stdin as an input stream. Defaults to 0.
#
# [*log_level*]
#   The logging level that statsite should use. One of: debug, info, warn,
#   error, or critical. All logs go to syslog, and stderr if that is a
#   TTY.  Default is debug.
#
# [*flush_interval*]
#   How often the metrics should be flushed to the sink in seconds.
#   Defaults to 10 seconds.
#
# [*timer_eps*]
#   The upper bound on error for timer estimates. Defaults to 1%.
#   Decreasing this value causes more memory utilization per timer.
#
# [*set_eps*]
#   The upper bound on error for unique set estimates. Defaults to 2%.
#   Decreasing this value causes more memory utilization per set.
#
# [*stream_cmd*]
#   This is the command that statsite invokes every flush_interval seconds
#   to handle the metrics. It can be any executable. It should read inputs
#   over stdin and exit with status code 0 on success. It defaults to the
#   graphite sink directed to localhost on port 2003
#
# [*input_counter*]
#   If set, statsite will count how many commands it received in the flush
#   interval, and the count will be emitted under this name. For example
#   if set to "numStats", then statsite will emit "counter.numStats" with
#   the number of samples it has received.
#
# [*pid_file*]
#   When daemonizing, where to put the pid file. Defaults to
#   /var/run/statsite.pid
#
# [*binary_stream*]
#   Should data be streamed to the stream_cmd in binary form instead of
#   ASCI form. Defaults to 0.
#
# [*histograms*]
#   An optional array of histogram configuration hashes with the following
#   keys:
#     [*name*]
#       The name of the histogram.
#
#     [*prefix*]
#       This is the key prefix to match on. The longest matching prefix
#       is used. If the prefix is blank, it is the default for all keys.
#
#     [*min*]
#       Floating value. The minimum bound on the histogram. Values below
#       this go into a special bucket containing everything less than
#       this value.
#
#     [*max*]
#       Floating value. The maximum bound on the histogram. Values above
#       this go into a special bucket containing everything more than
#       this value.
#
#     [*width*]
#       Floating value. The width of each bucket between the min and max.
#
#   Each histogram must specify all keys to be valid

class statsite (
  $version        = '0.6.0',
  $install_path   = '/opt/statsite',
  $config_path    = '/etc/statsite',
  $tcp_port       = 8125,
  $udp_port       = 8125,
  $bind_address   = '0.0.0.0',
  $parse_stdin    = 0,
  $log_level      = 'debug',
  $flush_interval = 10,
  $timer_eps      = 0.01,
  $set_eps        = 0.02,
  $stream_cmd     = 'python /opt/statsite/current/sinks/graphite.py',
  $input_counter  = undef,
  $pid_file       = '/var/run/statsite.pid',
  $binary_stream  = 0,
  $histograms     = [],
) {

  if $::osfamily != 'Debian' {
    fail("The ${::osfamily} is not currently supported.")
  }

  $config_file = "${config_path}/config"

  include statsite::install
  include statsite::config
  include statsite::service

  Class['::statsite::install'] ->
  Class['::statsite::config'] ~>
  Class['::statsite::service'] ->
  Class['::statsite']
}
