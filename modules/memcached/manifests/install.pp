class memcached::install{
    package{"memcached":
        ensure=>present,
        require=>Class["rabbitmq"],
        notify=>Package["python-memcache"],
    }
    package{"python-memcache":
        ensure=>present,
        require=>Package["memcached"],
    }
}
