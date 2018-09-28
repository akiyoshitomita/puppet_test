# profile::lb
#
# Puppet 体験POC用マニフェスト
# 
#  (c) Networld
#
class profile::lb () {
  include ::haproxy

  haproxy::listen { 'puppet00':
    collect_exported => false,
    ipaddress        => $facts['ipaddress'],
    ports            => '80',
  }

  Haproxy::Balancermember <<| listening_service == 'puppet00' |>>
}
