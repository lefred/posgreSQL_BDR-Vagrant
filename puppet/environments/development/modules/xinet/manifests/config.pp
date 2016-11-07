class xinet::config {
  file {
    "/etc/xinetd.d/pgbdrchk":
      ensure => present,
      owner => root, group => root,
      require => Class['xinet::packages'],
      source => "puppet:///modules/xinet/pgbdrchk";
  }
  file {
    "/usr/bin/pgsqlcheck.sh":
      ensure => present,
      owner => root, group => root,
      require => Class['xinet::packages'],
      source => "puppet:///modules/xinet/pgsqlcheck.sh";
  }
}
