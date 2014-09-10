# vagrant/puppet/modules/mysql/manifests/init.pp
class mysql {

  # Install mysql
  package { ['mysql-server']:
    ensure => present,
    require => Exec['apt-get update'],
  }

  # Run mysql
  service { 'mysql':
    ensure  => running,
    enable => true,
    require => Package['mysql-server'],
  }

  # Use a custom mysql configuration file
  file { '/etc/mysql/my.cnf':
    source  => 'puppet:///modules/mysql/my.cnf',
    require => Package['mysql-server'],
    notify  => Service['mysql'],
    mode => 644,
  }

  # We set the root password here
  # exec { 'set-mysql-password':
  #   unless  => 'mysqladmin -uroot -proot status',
  #   command => "mysqladmin -uroot password a9120ed2b58af37862a83f5b9f850819ed08b2a9",
  #   path    => ['/bin', '/usr/bin'],
  #   require => Service['mysql'];
  # }
}