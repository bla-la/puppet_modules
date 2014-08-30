class hadoop::nodemanager( $managerPort,
                              $schedulerPort,
                              $trackerPort,
                              $admnPort,
                              $webappPort,
                              $enabled = false)
{
    include hadoop

    $resourceManager = "${hadoop::resourceManagerHost}"
    $resourceManagerPort = "${managerPort}"
    $resourceManagerSchedulerPort = "${schedulerPort}"
    $resourceManagerTrackerPort = "${trackerPort}"
    $resourceManagerAdminPort = "${admnPort}"
    $resourceManagerWebappPort = "${webappPort}"


    $user = $hadoop::user
    $group = $hadoop::group
    $cofigPath = "${hadoop::base}/${hadoop::version}/config"
    $store = $hadoop::store
    $javaHome = "${hadoop::jdkPath}/${hadoop::jdkVersion}"
    $execCmd = "${hadoop::base}/${hadoop::version}/bin/yarn"
    $localDirs = "${store}/nodemanager" 
    $localLogDirs = "${store}/nodemanager-log"

    notice("### Configure Hadoop node manager.")
    file { "rm-yarn-site.xml.erb":
        ensure => present,
        path => "${cofigPath}/yarn-site.xml",
        mode => '0440',
        owner => $user,
        group => $group,
        content => template('hadoop/nm-yarn-site.xml.erb'),
        replace => true,
        require => File["hadoop-config-common"],
    }


    file { "hadoop-nm-localdir-dir":
        ensure => directory,
        recurse => true,
        path => $localDirs,
        owner => $user,
        group => $group
    }
    file { "hadoop-nm-locallogdir-dir":
        ensure => directory,
        recurse => true,
        path => $localLogDirs,
        owner => $user,
        group => $group,
        require => File["hadoop-nm-localdir-dir"]
    }



    runit::addexe{"hadoop-nm-node":
        exename => "start-nm-node",
        content => template('hadoop/start-nm-node.erb')}

    runit::enable{"hadoop-nm-node":
            require => File["hadoop-nm-locallogdir-dir"]}

}
