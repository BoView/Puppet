class rabbitmq{
    Exec{
        path=>"/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:/bin:/sbin",
        logoutput=>"on_failure",
    }
    package{"rabbitmq-server":
        ensure=>present,
    }
    exec{"add":
        command=>"rabbitmqctl add_user openstack root",
        require=>Package["rabbitmq-server"],
        notify=>Exec["auth"],
    }
    exec{"auth":
        command=>"rabbitmqctl set_permissions openstack \".*\" \".*\" \".*\"",
        require=>Exec["add"],
    }
}
