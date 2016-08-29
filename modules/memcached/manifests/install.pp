class memcached::install{
    package{"memcached":
        ensure=>present,
    }
}
