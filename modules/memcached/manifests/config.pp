class memcached::config{
    define file($ip){
        file{"/etc/memcached.conf":
            ensure=>present,
            content=>template("memcached/memcached.conf.erb"),
            require=>Class["memcached::install"],
            notify=>Class["memcached::service"],
        }
    }
}
