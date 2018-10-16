class nagios::import {

    Nagios_host <<||>> {
        require => Class[ 'nagios::server' ],
        notify  => Class[ 'nagios::server' ]
    }

    Nagios_service <<||>> {
        require => Class[ 'nagios::server' ],
        notify  => Class[ 'nagios::server' ]
    }
}


