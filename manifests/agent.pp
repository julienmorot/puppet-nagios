class nagios::agent (
	$nagservers = []
) {
	
	$nrpepkg_name = 'nagios-nrpe-server'
	$service_name = 'nagios-nrpe-server'
	ensure_packages(['nagios-plugins',$nrpepkg_name], {'ensure' => 'present'})

    File { '/etc/nagios/nrpe.cfg':
        ensure  => file,
        owner   => 'root',
        group   => 'root',
        mode    => '0644',
        content => template("${module_name}/nrpe.cfg.erb"),
        require => Package[$nrpepkg_name],
        notify  => Service[$service_name],
    }

    Service { $service_name:
        ensure  => running,
        hasrestart   => true,
        subscribe => File['/etc/nagios/nrpe.cfg'],
        require => Package[$nrpepkg_name],
    }


}


