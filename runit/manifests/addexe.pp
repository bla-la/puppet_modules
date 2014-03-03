
define runit::addexe($exename,
                     $content)
{
    include runit


    file { "runit-addexe-${name}":
        ensure => present,
        path => "${runit::root}/${name}/${exename}",
        mode => '0550',
        owner => 'root',
        group => 'root',
        content => $content,
        replace => true,
        before => File["runit-run-${name}"],
    }

    runit::service{"${name}":
            command => "${runit::root}/${name}/${exename}"}


}
