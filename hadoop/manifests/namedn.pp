class hadoop::namedn( $enabled = false)
{
    include hadoop

    $user = $hadoop::user
    $group = $hadoop::group
    $cofigPath = "${hadoop::base}/${hadoop::version}/config"
    $store = $hadoop::store
    $nameDir = "${store}/name"
    $javaHome = "${hadoop::jdkPath}/${hadoop::jdkVersion}"
    $execCmd = "${hadoop::base}/${hadoop::version}/bin/hdfs"

    notice("### Configure Hadoop named node.")
    file { "namehode-hdfs-site.xml.erb":
        ensure => present,
        path => "${cofigPath}/hdfs-site.xml",
        mode => '0440',
        owner => $user,
        group => $group,
        content => template('hadoop/namenode-hdfs-site.xml.erb'),
        replace => true,
        require => File["hadoop-config-common"],
    }

    file { "hadoop-name-dir":
        ensure => directory,
        recurse => true,
        path => $nameDir,
        owner => $user,
        group => $group
    }


    runit::addexe{"hadoop-name-node":
        exename => "start-name-node",
        content => template('hadoop/start-named-node.erb')}

    runit::enable{"hadoop-name-node":}

}
