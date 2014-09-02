class apt(
    $root =             '/etc/apt',
    $provider =         '/usr/bin/apt',
    $sources_list_d =    '/etc/apt/sources.list.d'
){

    notice("### root ${root} sources_list_d ${sources_list_d}")
    file { 'sources.list.d':
        ensure => directory,
        path => $sources_list_d,
        owner => root,
        group => root,
        purge => $purge_sources_list_d,
        recurse => $purge_sources_list_d
        #notify => Exec['apt_update'],
    }


#    file { 'sources.list':
#        ensure => present,
#        path => "${root}/sources.list",
#        owner => root,
#        group => root,
#        mode => '0644',
#        source => "puppet:///modules/apt/source.list"
#    }


    apt::update{"apt-update":}

}
