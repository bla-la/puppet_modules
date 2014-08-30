class hbase::master( $enabled = false)
{
  include hbase

  $user = $hbase::user
  $group = $hbase::group
  $javaHome = "${hbase::jdkPath}/${hbase::jdkVersion}"
  $execCmd = "${hbase::base}/${hbase::version}/bin/hbase"


    notice("### Configure HBase master.")


    runit::addexe{"hbase-master":
      exename => "start-hbase-master",
      content => template('hbase/start-hbase-master.erb'),
      require => File["hbase-config-common"]}

    runit::enable{"hbase-master":}
}
