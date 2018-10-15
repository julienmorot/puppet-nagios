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

    File { '/etc/nagios/nrpe_local.cfg':
        ensure  => file,
        owner   => 'root',
        group   => 'root',
        mode    => '0644',
        source  => "puppet:///modules/${module_name}/nrpe_local.cfg",
        require => Package[$nrpepkg_name],
        notify  => Service[$service_name],
    }

    File { 'check_cpu':
        path    => '/usr/lib/nagios/plugins/check_cpu',
        ensure  => file,
        mode    => '755',
        owner   => 'root',
        group   => 'root',
        require => Package['nagios-plugins'],
        source  => "puppet:///modules/${module_name}/check_cpu"
    }
    File { 'check_mem':
        path    => '/usr/lib/nagios/plugins/check_mem',
        ensure  => file,
        mode    => '755',
        owner   => 'root',
        group   => 'root',
        require => Package['nagios-plugins'],
        source  => "puppet:///modules/${module_name}/check_mem"
    }

    Service { $service_name:
        ensure  => running,
        hasrestart   => true,
        subscribe => File['/etc/nagios/nrpe.cfg'],
        require => Package[$nrpepkg_name],
    }


}


