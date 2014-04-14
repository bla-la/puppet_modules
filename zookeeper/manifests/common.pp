define zookeeper::common()
{
    include zookeeper

    $user = $zookeeper::user
    $group = $zookeeper::group
    $cofigPath = "${zookeeper::base}/${zookeeper::version}/conf"
    $zkBasePath = "${zookeeper::base}/${zookeeper::version}"
    $defaultFs = $zookeeper::defaultFs
    $defaultFsPort = $zookeeper::defaultFsPort
    $store = $zookeeper::store
    $zkHosts = $zookeeper::zkHosts
    $dataDir = "${store}/zk"
    $clientPort = $zookeeper::clientPort
    $javaHome = "${zookeeper::jdkPath}/${zookeeper::jdkVersion}"

    $myid = get_myid($fqdn,$zkHosts)
    if $myid != -1 {
        notice("### ${fqdn} zookeeper myid is:${myid}")

        file { "zookeeper-config-common":
            ensure => directory,
            path => $cofigPath,
            owner => $user,
            group => $group
        }


        file { "zoo.cfg":
            ensure => present,
            path => "${cofigPath}/zoo.cfg",
            mode => '0440',
            owner => $user,
            group => $group,
            content => template('zookeeper/zoo.cfg.erb'),
            replace => true,
            require => File["zookeeper-config-common"],
        }

        file { "zookeeper-store":
            ensure => directory,
            path => "${dataDir}",
            owner => $user,
            group => $group,
	    recurse => true
        }
        file { "zookeeper.myid":
            ensure => present,
            path => "${dataDir}/myid",
            mode => '0440',
            owner => $user,
            group => $group,
            content => template('zookeeper/myid.erb'),
            replace => true,
            require => File["zookeeper-store"],
        }
	
	runit::addexe{"zookeeper":
		exename => "start-zookeeper",
        	content => template('zookeeper/start-zookeeper.erb')}

        runit::enable{"zookeeper":}


    }

}
