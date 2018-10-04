# profile::lb
#
# Puppet 体験POC用マニフェスト
# 
#  (c) Networld
#
class profile::web(){
  class { 'apache' : } ->

  file  { '/var/www/html/index.html' :
    ensure  => file,
    content => epp('profile/index.html.epp',{ servername => $facts['fqdn']　}) ,
  } ->

  file { '/var/www/html/P-Icon-Amber-White-sm.png' :
    ensure => file,
    source => 'puppet:///modules/profile/P-Icon-Amber-White-sm.png'
  }

  @@haproxy::balancermember { $facts['hostname'] :
    listening_service => 'puppet00',
    ports             => '80',
    server_names      => $facts['hostname'],
    ipaddresses       => $facts['ipaddress'],
    options           => 'check',
  }
}
