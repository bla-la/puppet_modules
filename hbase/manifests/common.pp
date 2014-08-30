define hbase::common()
{
  include hbase
  include zookeeper
  
  $user = $hbase::user
  $group = $hbase::group
  $cofigPath = "${hbase::base}/${hbase::version}/conf"
  $hdfsNamenodeUri = $hbase::hdfsNamenodeUri
  $zookeererQuorun = get_zkQuorum($zookeeper::zkHosts)
  
  
  file { "hbase-config-common":
    ensure => directory,
    path => $cofigPath,
    owner => $user,
    group => $group
  }


  file { "hbase-site.xml":
    ensure => present,
    path => "${cofigPath}/hbase-site.xml",
    mode => '0440',
    owner => $user,
    group => $group,
    content => template('hbase/hbase-site.xml.erb'),
    replace => true,
    require => File["hbase-config-common"],
  }

}
