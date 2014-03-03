class puppet::master( $enabled = false)
{
    include puppet

    runit::service{"puppet-master":
                        command => "/bin/puppet master --no-daemonize --verbose"}
    runit::enable{"puppet-master":}
}
