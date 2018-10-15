class nagios::server (

) {

    $nrpepkg_name = 'nagios-nrpe-plugin'
    $service_name = 'nagios'
    ensure_packages(['nagios-plugins',$nrpepkg_name], {'ensure' => 'present'})


}


