# == Class redis_sentinel::config
#
# This class is called from redis_sentinel
#
class redis_sentinel::config {
  if $redis_sentinel::ensure == 'present' {
    concat { $redis_sentinel::config_file:
      owner => $redis_sentinel::user,
      group => $redis_sentinel::group,
      mode  => '0440'
    }

    concat::fragment { 'sentinel_header':
      target  => $redis_sentinel::config_file,
      content => "#This file managed by the redis_sentinel puppet module\ndaemonize yes\nlogfile /var/log/redis/redis-sentinel.log\npidfile /var/run/redis/redis-sentinel.pid",
      order   => '01',
    }
  } else {
    file { $redis_sentinel::config_file:
      ensure => absent
    }
  }
}
