define runit::enable
{
    include runit
    $link_source = "${runit::root}/${name}"
    file { "${runit::services}/${name}":
        ensure => 'link',
        target => "${link_source}",
        require => File["runit-run-${name}"]
    }
}
