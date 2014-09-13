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