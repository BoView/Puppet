class memcached::install{
    #package{"memcached":
    #    ensure=>present,
    #    require=>Class["rabbitmq"],
    #    notify=>Package["python-memcache"],
    #}
    #package{"python-memcache":
    #    ensure=>present,
    #    require=>Package["memcached"],
    #}
    Exec{
        path=>"/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:/bin:/sbin",
        logoutput=>"on_failure",
    }
    exec{"memcached":
        command=>"apt-get install memcached -y --force-yes",
        require=>Class["rabbitmq"],
        notify=>Exec["python-memcache"],
    }
    exec{"python-memcache":
        command=>"apt-get install python-memcache -y --force-yes",
        require=>Exec["memcached"],
    }
}
