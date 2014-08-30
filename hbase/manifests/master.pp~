class hadoop::datanode( $enabled = false)
{
    include hadoop

    $user = $hadoop::user
    $group = $hadoop::group
    $cofigPath = "${hadoop::base}/${hadoop::version}/config"
    $store = $hadoop::store
    $dataDir = "${store}/data"
    $javaHome = "${hadoop::jdkPath}/${hadoop::jdkVersion}"
    $execCmd = "${hadoop::base}/${hadoop::version}/bin/hdfs"


    notice("### Configure Hadoop data node.")
    file { "datahode-hdfs-site.xml.erb":
        ensure => present,
        path => "${cofigPath}/hdfs-site.xml",
        mode => '0440',
        owner => $user,
        group => $group,
        content => template('hadoop/datanode-hdfs-site.xml.erb'),
        replace => true,
        require => File["hadoop-config-common"],
    }

    file { "hadoop-data-dir":
        ensure => directory,
        recurse => true,
        path => $dataDir,
        owner => $user,
        group => $group
    }


    runit::addexe{"hadoop-data-node":
        exename => "start-data-node",
        content => template('hadoop/start-data-node.erb')}

    runit::enable{"hadoop-data-node":}
}
