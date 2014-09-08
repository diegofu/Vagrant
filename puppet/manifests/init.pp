exec { 'apt-get update':
  path => '/usr/bin',
}

package { 'vim':
  ensure => present,
}

file { '/var/www/':
  ensure => 'directory',
}

class { 'apt':
    always_apt_update => true,
}

class { 'nginx': }

class { 'php': }

class { 'mysql': }
