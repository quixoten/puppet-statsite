# puppet-statsite

Puppet module to manage [statsite](https://github.com/armon/statsite)

## Usage

```puppet
class { 'statsite':
  stream_cmd => "python $statsite::install_path/sinks/graphite.py graphite.example.com 2003",
}
```

**WORK IN PROGRESS**
