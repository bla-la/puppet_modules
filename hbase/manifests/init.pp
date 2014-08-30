class hbase($hdfsNamenodeUri,
            $user = "hadoop",
            $group = "hadoop",
            $pkg = "hbase-v0.98.1", 
            $version = "v0_98_1",
            $base = "/opt/hbase",
            $jdkPath = "/opt/jdk",
            $jdkVersion = "v7_51")
{
  notice("# HBase configure")
  include jdk
  apt::install{"${pkg}":}
  

  hbase::common{"hbase-common":}
}
