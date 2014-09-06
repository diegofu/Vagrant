# File:  modules/php/manifests/params.pp
# Class: php::params
#
# Sets internal variables and defaults for php module.
#
class php::params {

    ## DEFAULTS FOR VARIABLES USERS CAN SET
    # Here we set the defaults, you can provide your custom variables
    # externally, for example, in nodes.pp.

    # Set the default version of PHP we are using.
    $version = '5.6.0'
}