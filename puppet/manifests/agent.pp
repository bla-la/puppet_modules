class puppet::agent( $enabled = false)
{
    include puppet

    runit::service{"puppet-agent":
                        command => "/bin/puppet agent --no-daemonize --verbose"}
    runit::enable{"puppet-agent":}
}
