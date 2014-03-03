class netconsole( $remote_mac,
                    $local_addr,
                    $remote_host,
                    $remote_port='6066',
                    $dmesg_level='7',
                    $local_int='eth0'){

    $localInt = $local_int
    $localAddr = $local_addr
    $remoteAddr = $remote_host
    $remotePort = $remote_port
    $remoteMac = $remote_mac
    $dmesgLevel = $dmesg_level 

    runit::addexe{"netconsole":
        exename => "netconsole-ena",
        content => template('netconsole/netconsole-ena.erb')}
    runit::enable{"netconsole":}
}
