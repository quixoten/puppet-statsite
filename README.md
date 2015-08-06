# puppet-statsite

Puppet module to manage [statsite](https://github.com/armon/statsite)

## Usage

```puppet
class { 'statsite':
  graphite_host   => 'graphite.example.com',
}
```

## Parameters
- `version`
  The version of statsite to install. Defaults to 0.6.0

- `install_path`
  The path that statsite will be installed. Defaults to /opt/statsite

- `config_path`
  Statsite's configuration directory. Defaults to /etc/statsite

- `tcp_port`
  Integer, sets the TCP port to listen on. Default 8125. 0 to disable.

- `udp_port`
  Integer, sets the UDP port. Default 8125. 0 to disable.

- `bind_address`
  The address to bind on. Defaults to 0.0.0.0

- `parse_stdin`
  Enables parsing stdin as an input stream. Defaults to 0.

- `log_level`
  The logging level that statsite should use. One of: debug, info, warn,
  error, or critical. All logs go to syslog, and stderr if that is a TTY.
  Default is debug.

- `flush_interval`
  How often the metrics should be flushed to the sink in seconds.
  Defaults to 10 seconds.

- `timer_eps`
  The upper bound on error for timer estimates. Defaults to 1%.
  Decreasing this value causes more memory utilization per timer.

- `set_eps`
  The upper bound on error for unique set estimates. Defaults to 2%.
  Decreasing this value causes more memory utilization per set.

- `stream_cmd`
  This is the command that statsite invokes every flush_interval seconds
  to handle the metrics. It can be any executable. It should read inputs
  over stdin and exit with status code 0 on success. If this parameter is
  defined, all graphite_* parameters will be ignored.

- `graphite_host`
  The hostname of the graphite server to sink metrics to every
  flush_interval seconds. Defaults to "localhost". This parameter will be
  ignored if stream_cmd is set.

- `graphite_port`
  The port of the graphite server. Defaults to 2003. This parameter
  will be ignored if stream_cmd is set.

- `graphite_prefix`
  A prefix to add to the keys sent to graphite. Defaults to "statsite.".
  Note: The trailing dot is necessary. This parameter will be ignored if
  stream_cmd is set.

- `graphite_attempts`
  The number of re-connect attempts before failing. Defaults to 3. This
  parameter will be ignored if stream_cmd is set.

- `input_counter`
  If set, statsite will count how many commands it received in the flush
  interval, and the count will be emitted under this name. For example
  if set to "numStats", then statsite will emit "counter.numStats" with
  the number of samples it has received.

- `pid_file`
  When daemonizing, where to put the pid file. Defaults to
  /var/run/statsite.pid

- `binary_stream`
  Should data be streamed to the stream_cmd in binary form instead of
  ASCI form. Defaults to 0.

- `use_type_prefix`
  Should prefixes with message type be added to the messages. Does not
  affect global_prefix. Defaults to 1.

- `extended_counters`
  If enabled, the counter output is extended to include all the computed
  summary values. Otherwise, the counter is emitted as just the sum value.
  Summary values include mean, stdev, sum, sum_sq, lower, upper, and rate.
  Defaults to false.

- `histograms`
  An optional array of histogram configuration hashes with the following
  keys:

  - `name`
    The name of the histogram.

  - `prefix`
    This is the key prefix to match on. The longest matching prefix
    is used. If the prefix is blank, it is the default for all keys.

  - `min`
    Floating value. The minimum bound on the histogram. Values below
    this go into a special bucket containing everything less than
    this value.

  - `max`
    Floating value. The maximum bound on the histogram. Values above
    this go into a special bucket containing everything more than
    this value.

  - `width`
    Floating value. The width of each bucket between the min and max.

  Each histogram must specify all keys to be valid

## Supported Platforms
- Debian / Ubuntu (upstart)
- Fedora / Centos 7 / Redhat 7 (systemd)


