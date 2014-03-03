
define runit::service($command,
                     $user = 'root',
                     $group = 'root',
                     $log_size = 268435456,
                     $log_max_files = 4,
                     $log_min_files = 4,
                     $log_rotate_time = 86400)
{
    include runit

    file { "runit-sv-${name}":
        ensure => directory,
        path => "${runit::root}/${name}",
        owner => root,
        group => root
    }


    $logdir = "${runit::logdir}/${name}"
    $service = $name


    file { "runit-log-${name}":
        ensure => directory,
        path => "${runit::logdir}/${name}",
        owner => $user,
        group => $group,
        require => Exec["runit-log"]
    }


    file { "runit-logrun-${name}":
        ensure => directory,
        path => "${runit::root}/${name}/log",
        owner => root,
        group => root,
        require => File["runit-log-${name}"],
    }


    file { "runit-log-config-${name}":
        ensure => present,
        path => "${runit::root}/${name}/log/config",
        mode => '0440',
        owner => $user,
        group => $group,
        content => template('runit/log_config.erb'),
        replace => true,
        require => File["runit-logrun-${name}"]
    }


    file { "runit-log-run-${name}":
        ensure => present,
        path => "${runit::root}/${name}/log/run",
        mode => '0550',
        owner => $user,
        group => $group,
        content => template('runit/log_run.erb'),
        replace => true,
        require => File["runit-logrun-${name}"]
    }


    file { "runit-run-${name}":
        ensure => present,
        path => "${runit::root}/${name}/run",
        mode => '0550',
        owner => $user,
        group => $group,
        content => template('runit/run.erb'),
        replace => true,
        require => File["runit-log-run-${name}"]
    }


}
