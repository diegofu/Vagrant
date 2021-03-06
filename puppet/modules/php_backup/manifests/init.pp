# vagrant/puppet/modules/php/manifests/init.pp
class php {

    # Add repo for php 5.5.0
    apt::ppa { 'ppa:ondrej/php5': }

    # Install the php5-fpm and php5-cli packages
    package { [
        'php5-fpm',
        'php5-cli',
        'php5-gd',
        'php5-mysql',
        'php5-dev',
        'php-pear'
    ]:
        ensure => present,
        require => Apt::Ppa['ppa:ondrej/php5'],
    }

    # Make sure php5-fpm is running
    service { 'php5-fpm':
        ensure => running,
        require => Package['php5-fpm'],
    }

    # Make sure php5-fpm is running
    service { 'php5-xdebug':
        ensure => running,
        require => Package['php5-fpm'],
        notify => Service['php5-fpm']
    }

    # Use a custom mysql configuration file
	file { '/etc/php5/fpm/pool.d/www.conf':
		source  => 'puppet:///modules/php/www.conf',
		require => Package['php5-fpm'],
		mode => 644,
        notify => Service['php5-fpm']
	}
    
}