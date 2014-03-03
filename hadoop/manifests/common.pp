define hadoop::common()
{
    include hadoop

    $user = $hadoop::user
    $group = $hadoop::group
    $cofigPath = "${hadoop::base}/${hadoop::version}/config"
    $defaultFs = $hadoop::defaultFs
    $defaultFsPort = $hadoop::defaultFsPort
    $store = $hadoop::store

    file { "hadoop-config-common":
        ensure => directory,
        path => $cofigPath,
        owner => $user,
        group => $group
    }


    file { "core-site.xml":
        ensure => present,
        path => "${cofigPath}/core-site.xml",
        mode => '0440',
        owner => $user,
        group => $group,
        content => template('hadoop/core-site.xml.erb'),
        replace => true,
        require => File["hadoop-config-common"],
    }

    file { "hadoop-store":
        ensure => directory,
        path => "${store}",
        owner => $user,
        group => $group,
    }

}
