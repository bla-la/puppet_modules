class openswan( $private_net='192.168.30.0/24',
      		$psk){

      apt::install{"openswan":}
      apt::install{"xl2tpd":}
      apt::install{"ppp":}

      $address = $::ipaddress
      
      file { "/etc/ipsec.conf":
        ensure => present,
        path => "/etc/ipsec.conf",
        mode => '0644',
        owner => 'root',
        group => 'root',
        content => template('openswan/ipsec.conf.erb'),
        replace => true
     }


      file { "/etc/ipsec.secrets":
        ensure => present,
        path => "/etc/ipsec.secrets",
        mode => '0600',
        owner => 'root',
        group => 'root',
        content => template('openswan/ipsec.secrets.erb'),
        replace => true
     }

}