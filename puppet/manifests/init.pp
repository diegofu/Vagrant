exec { 'apt-get update':
  path => '/usr/bin',
}

package { 'vim':
  ensure => present,
}

file { '/var/www/':
  ensure => 'directory',
}

include apt

apt::ppa { 'ppa:nginx/stable': }

include nginx, php, mysql