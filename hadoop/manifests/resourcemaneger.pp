class hadoop::resourcemaneger( $managerPort,
                              $schedulerPort,
                              $trackerPort,
                              $admnPort,
                              $webappPort,
                              $schedulerClass = "org.apache.hadoop.yarn.server.resourcemanager.scheduler.capacity.CapacityScheduler",
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
    $nameDir = "${store}/name"
    $javaHome = "${hadoop::jdkPath}/${hadoop::jdkVersion}"
    $execCmd = "${hadoop::base}/${hadoop::version}/bin/yarn"

    notice("### Configure Hadoop resource manager.")
    file { "rm-yarn-site.xml.erb":
        ensure => present,
        path => "${cofigPath}/yarn-site.xml",
        mode => '0440',
        owner => $user,
        group => $group,
        content => template('hadoop/rm-yarn-site.xml.erb'),
        replace => true,
        require => File["hadoop-config-common"],
    }



    runit::addexe{"hadoop-rm-node":
        exename => "start-rm-node",
        content => template('hadoop/start-rm-node.erb')}

    runit::enable{"hadoop-rm-node":}

}
