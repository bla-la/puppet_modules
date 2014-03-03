class ptp( $enabled = true,
                     $base = "/opt/dst/ptp/1_4/",
                     $pkg = "ptp-v1.4",
                     $pkg_version = "v1.4",
                     $interface = "eth0")
{
    apt::install{"${pkg}":
        version => "${pkg_version}"}
    runit::service{"ptp":
                        command => "${base}/bin/ptp4l  -i ${interface} -m"}
    runit::enable{"ptp":}
}
