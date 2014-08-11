# Manage the statsite service
class statsite::service inherits statsite {
  service { 'statsite':
    ensure   => running,
    provider => $init_style,
  }
}
