class php {

    # Load the configuration parameters used in this module. See params.pp.
    include php::params

    # Make sure all required packages/classes are installed. See install.pp.
    include php::install
}