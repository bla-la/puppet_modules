class zookeeper( $zkHosts, 
            $clientPort = 2181,
            $user = "zookeeper",
            $group = "zookeeper",
            $pkg = "zookeeper-v3.4.6", 
            $version = "v3_4_6",
            $base = "/opt/dst/zk",
            $jdkPath = "/opt/jdk",
            $jdkVersion = "v7_51",
            $store = "/store")
{
  include jdk
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

  zookeeper::common{"zookeeper-common":}
}
