class rabbitmq{
    Exec{
        path=>"/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:/bin:/sbin",
        logoutput=>"on_failure",
    }
    exec{"rabbitmq-server":
        command=>"apt-get install rabbitmq-server -y --force-yes",
        require=>Class["mysql"],
        notify=>Exec["add user"],
    }
    exec{"add user":
        command=>"rabbitmqctl add_user openstack root",
        require=>Exec["rabbitmq-server"],
        notify=>Exec["auth"],
    }
    exec{"auth":
        command=>"rabbitmqctl set_permissions openstack \".*\" \".*\" \".*\"",
        require=>Exec["add user"],
        notify=>Class["memcached"],
    }
}
