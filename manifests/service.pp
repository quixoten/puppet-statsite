# Manage the statsite service
class statsite::service {
  service { 'statsite':
    ensure   => running,
    provider => $statsite::init_style,
  }
}
