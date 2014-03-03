class runit( $root = '/etc/sv',
           $services = '/etc/service',
           $logdir = '/sv/log')
{
    apt::install{"runit":}
   

    file { 'runit-sv':
        ensure => directory,
        path => $root,
        owner => root,
        group => root
    }

    file { 'runit-service':
        ensure => directory,
        path => $services,
        owner => root,
        group => root
    }

    exec {"runit-log":
        command => "mkdir -p ${logdir}",
        path    => "/bin:/usr/bin/"
    }

    #require => Class['apt::install[runit]']
}
