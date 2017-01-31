# Manage the statsite service
class statsite::service {
  service { 'statsite':
    ensure => $statsite::service_ensure,
    enable => $statsite::service_enable,
  }
}
