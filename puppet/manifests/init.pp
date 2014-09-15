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

apt::ppa { 'ppa:ondrej/php5': }

class { 'php':
    # version => '5.5.16',
    service => 'nginx',
    require => Apt::Ppa['ppa:ondrej/php5'],
}


php::module {'fpm':}
php::module {'mysql':}
php::module {'xdebug':}
php::module {'gd':}

# Use a custom www.conf configuration file
file { '/etc/php5/fpm/pool.d/www.conf':
    source  => 'puppet:///modules/php/www.conf',
    require => Package['php5-fpm'],
    mode => 644,
    # notify => Service['php5-fpm']
}

# Use a custom www.conf configuration file
file { '/etc/php5/fpm/php.ini':
    source  => 'puppet:///modules/php/php.ini',
    require => Package['php5-fpm'],
    mode => 644,
    # notify => Service['php5-fpm']
}

# MySql
class { '::mysql::server':
	override_options => {
		'mysqld' => { 
			'bind-address' => '0.0.0.0',
		}
	},
	restart => true,
	users => {
		'root@10.0.2.2' => {
			ensure                   => 'present',
		    max_connections_per_hour => '0',
		    max_queries_per_hour     => '0',
		    max_updates_per_hour     => '0',
		    max_user_connections     => '0',
		}
	},
	grants => {
		'root@10.0.2.2/*.*' => {
			ensure     => 'present',
		    options    => ['GRANT'],
		    privileges => ['ALL'],
		    table      => '*.*',
		    user       => 'root@10.0.2.2',
		}
	}
}

class { 'composer': }