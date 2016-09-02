class memcached::config{
    #file{"/etc/memcached.conf":
    #    ensure=>present,
    #    source=>"puppet:///modules/memcached/memcached.conf",
    #    require=>Class["memcached::install"],
    #    notify=>Class["memcached::service"],
    #}
    define file($ip){
        file{"/etc/memcached.conf":
            ensure=>present,
            content=>template("memcached/memcached.conf.erb"),
            require=>Class["memcached::install"],
            notify=>Class["memcached::service"],
        }
    }
}
