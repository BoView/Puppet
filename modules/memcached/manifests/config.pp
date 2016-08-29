class memcached::config{
    file{"/etc/memcached.conf":
        ensure=>present,
        source=>"puppet:///modules/memcached/memcached.conf",
        require=>Class["memcached::install"],
        notify=>Class["memcached::service"],
    }
}
