class nagios::server (
    $adminuser = 'nagiosadmin',
    $adminpwd = 'secret'
) {
    include nagios::import

    $nrpepkg_name = 'nagios-nrpe-plugin'
    $nagserverpkg_name = 'nagios3'
    $service_name = 'nagios3'
    ensure_packages(['nagios-plugins',$nrpepkg_name,$nagserverpkg_name], {'ensure' => 'present'})

    File { '/etc/nagios3/services/':
        ensure  => directory,
        owner   => 'root',
        group   => 'root',
    }

    File { '/etc/nagios3/hosts/':
        ensure  => directory,
        owner   => 'root',
        group   => 'root',
    }

    File { '/etc/nagios3/cgi.cfg':
        ensure  => file,
        owner   => 'root',
        group   => 'root',
        mode    => '0644',
        content => template("${module_name}/cgi.cfg.erb"),
        require => Package[$nrpepkg_name],
    }


    File { '/etc/nagios3/nagios.cfg':
        ensure  => file,
        source  => "puppet:///modules/${module_name}/nagios.cfg",
        owner   => "root",
        group   => "root",
        mode    => "0644",
    }

    file { 'nagios_conf':
        path => "/etc/nagios3/conf",
        ensure => "directory",
        owner => "root",
        group => "root",
        mode => "0644",
        recurse => true,
        source => "puppet:///modules/${module_name}/server",
    }

    Exec { 'nag_perms':
        command => "/bin/chmod -R 644 /etc/nagios3/hosts/*.cfg /etc/nagios3/services/*.cfg",
    }

    Exec { 'nag_web_admin_user':
        command => "/usr/bin/touch /etc/nagios3/htpasswd.users && /usr/bin/htpasswd -i -b /etc/nagios3/htpasswd.users ${adminuser} ${adminpwd}",
        unless  => "/usr/bin/htpasswd -i -b -v /etc/nagios3/htpasswd.users ${adminuser} ${adminpwd}",
    }

    Exec { 'allow_external_checks1':
        command => "/usr/bin/dpkg-statoverride --update --add nagios www-data 2710 /var/lib/nagios3/rw",
        unless  => "/usr/bin/dpkg-statoverride --list |/bin/grep 'nagios www-data 2710 /var/lib/nagios3/rw'",
    }

    Exec { 'allow_external_checks2':
        command => "/usr/bin/dpkg-statoverride --update --add nagios nagios 751 /var/lib/nagios3",
        unless  =>  "/usr/bin/dpkg-statoverride --list |/bin/grep 'nagios nagios 751 /var/lib/nagios3'"
    }

    Service { $service_name:
        ensure  => running,
        enable  => true,
    }

}


