class hadoop( $defaultFs,
             $resourceManagerHost,
            $defaultFsPort = 8020,
            $user = "hadoop",
            $group = "hadoop",
            $pkg = "hadoop-v2.2.0", 
            $version = "v2_2_0",
            $base = "/opt/hadoop",
            $jdkPath = "/opt/jdk",
            $jdkVersion = "v7_51",
            $store = "/store")
{
    apt::install{"jdk-v7.51":}
    apt::install{"${pkg}":}

    group { $group: 
        ensure => "present"
    }
    user { $user:
        comment => "User for run hadoop services",
        home    => "$base",
        shell   => "/bin/false",
        managehome => 'true',
        groups => $group
    }

    hadoop::common{"hadoop-common":}
}
