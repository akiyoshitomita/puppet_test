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
    content => epp('profile/index.html.epp',$servername = $facts['trusted']['certname']) ,
  } ->

  file { '/var/www/html/P-Icon-Amber-White-sm.png' :
    ensure => file,
    source => 'puppet:///modules/profile/P-Icon-Amber-White-sm.png'
  }

  @@haproxy::balancermember { $facts['trusted']['certname'] :
    listening_service => 'puppet00',
    ports             => '80',
    server_names      => $facts['trusted']['certname'],
    ipaddresses       => $facts['ipaddress'],
    options           => 'check',
  }
}
