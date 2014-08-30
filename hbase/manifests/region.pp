class hbase::region( $enabled = false)
{
  include hbase
  include runit


  $user = $hbase::user
  $group = $hbase::group
  $javaHome = "${hbase::jdkPath}/${hbase::jdkVersion}"
  $execCmd = "${hbase::base}/${hbase::version}/bin/hbase"


  notice("### Configure HBase region.")


  runit::addexe{"hbase-region":
    exename => "start-hbase-region",
    content => template('hbase/start-hbase-region.erb'),
    require => File["hbase-config-common"]}
  
  runit::enable{"hbase-region":}
}

