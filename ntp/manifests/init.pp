class ntp( $ntp_host='ntp.localhost.home' ){

    apt::install{"ntpdate":}

    cron { ntp:
        command => "/usr/sbin/ntpdate -b ${ntp_host}",
        user    => root,
        minute  => '*/5'
    }
}
