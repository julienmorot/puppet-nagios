class nagios::export::linux {

    @@nagios_host { $::fqdn :
        ensure              => present,
        address             => $::ipaddress,
        alias               => $::fqdn,
        use                 => 'linux-server',
        hostgroups          => 'all-servers',
        target              => "/etc/nagios3/hosts/${::fqdn}.cfg",
    }

     @@nagios_service { "${::fqdn}_check-load":
        ensure              => present,
        use                 => 'generic-service', 
        host_name           => $::fqdn,
        service_description => 'Load Average',
        check_command       => 'check_nrpe_nossl!check_load',
        target              => "/etc/nagios3/services/${::fqdn}.cfg",
    }

     @@nagios_service { "${::fqdn}_check-cpu":
        ensure              => present,
        use                 => 'generic-service',
        host_name           => $::fqdn,
        service_description => 'CPU',
        check_command       => 'check_nrpe_nossl!check_cpu',
        target              => "/etc/nagios3/services/${::fqdn}.cfg",
        notifications_enabled => "0",
    }

     @@nagios_service { "${::fqdn}_check-mem":
        ensure              => present,
        use                 => 'generic-service',
        host_name           => $::fqdn,
        service_description => 'MEM',
        check_command       => 'check_nrpe_nossl!check_mem',
        target              => "/etc/nagios3/services/${::fqdn}.cfg",
    }

     @@nagios_service { "${::fqdn}_check-disk-slash":
        ensure              => present,
        use                 => 'generic-service',
        host_name           => $::fqdn,
        service_description => 'Partition /',
        check_command       => 'check_nrpe_nossl!check_disk_slash',
        target              => "/etc/nagios3/services/${::fqdn}.cfg",
    }

     @@nagios_service { "${::fqdn}_check-proc-ntpd":
        ensure              => present,
        use                 => 'generic-service',
        host_name           => $::fqdn,
        service_description => 'Processus NTPD',
        check_command       => 'check_nrpe_nossl!check_proc_ntpd',
        target              => "/etc/nagios3/services/${::fqdn}.cfg",
    }
     @@nagios_service { "${::fqdn}_check-proc-sshd":
        ensure              => present,
        use                 => 'generic-service',
        host_name           => $::fqdn,
        service_description => 'Processus SSHD',
        check_command       => 'check_nrpe_nossl!check_proc_sshd',
        target              => "/etc/nagios3/services/${::fqdn}.cfg",
    }

}
