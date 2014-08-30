define runit::enable
{
    include runit
    notice("##enable ${name}")
    $link_source = "${runit::root}/${name}"
    file { "${runit::services}/${name}":
        ensure => 'link',
        target => "${link_source}",
        require => File["runit-run-${name}"]
    }
}
