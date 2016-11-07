class profile::haproxy {

  # You must include haproxy as ::haproxy because Puppet will search 
  # the current scope first and find haproxy in profile. By specifying
  # ::haproxy you're telling Puppet to look for module haproxy.
  include ::haproxy
  
  file {
    "/etc/haproxy/haproxy.cfg":
      ensure => present,
      owner => root, group => root,
      source => "puppet:///modules/profile/$hostname/haproxy.cfg";
  }

}
