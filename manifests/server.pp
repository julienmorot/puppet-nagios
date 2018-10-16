class nagios::server (

) {

	
	include nagios::import

    $nrpepkg_name = 'nagios-nrpe-plugin'
	$nagserverpkg_name = 'nagios3'
    $service_name = 'nagios'
    ensure_packages(['nagios-plugins',$nrpepkg_name,$nagserverpkg_name], {'ensure' => 'present'})


}


