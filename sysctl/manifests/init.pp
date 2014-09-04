class sysctl( $userSysctl={})
{
  $defaultSysctl = {
    'fs.file-max' => '2097152',
    'net.core.somaxconn' => '8192',
    'net.core.rmem_max' => '16777216',
    'net.core.wmem_max' => '16777216',
    'net.core.rmem_default' => '16777216',
    'net.core.wmem_default' => '16777216',
    'net.core.optmem_max' => '16777216',
    'net.ipv4.tcp_fin_timeout' => '15',
    'net.ipv4.tcp_keepalive_time' => '1800',
    'net.ipv4.tcp_mem' => '16777216 16777216 16777216',
    'net.ipv4.tcp_rmem' => '4096 87380 16777216',
    'net.ipv4.tcp_wmem' => '4096 65536 16777216',
    'net.ipv4.tcp_syncookies' => '1',
    'net.ipv4.ip_local_port_range' => '10000 65535',
    'vm.swappiness' => '60',
    'kernel.core_pattern' => '/cores/core.%t.%p',
    'kernel.core_uses_pid' => '1',
    'net.ipv4.tcp_low_latency' => '1',
    'net.core.dev_weight' => '16',
    'kernel.sem' => '250 256000 32 1024',
    'kernel.shmmax' => '1073741824',
    'kernel.shmall' => '3774873',
    'kernel.msgmax' => '65535',
    'kernel.msgmnb' => '65535',
    'net.ipv4.conf.all.arp_announce' => '2',
    'net.ipv4.conf.all.arp_ignore' => '1',
    'net.ipv4.udp_rmem_min' => '16384',
    'net.ipv4.udp_wmem_min' => '16384',
    'net.ipv4.tcp_congestion_control' => 'cubic',
    'net.core.netdev_max_backlog' => '250000',
    'vm.min_free_kbytes' => '131072',
    'kernel.sched_min_granularity_ns' => '10000000',
    'kernel.sched_wakeup_granularity_ns' => '15000000',
    'vm.dirty_ratio' => '40'
  }

  
  file { "/etc/sysctl.conf":
    ensure => present,
    path => "/etc/sysctl.conf",
    mode => '0440',
    owner => "root",
    group => "root",
    content => template('sysctl/sysctl.conf.erb'),
    replace => true
  }

  exec {"sysctl-apply":
    command => "sysctl -p",
    path    => "/sbin/",
    require => File['/etc/sysctl.conf']
  }
}
