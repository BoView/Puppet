class keystone::config{
    Exec{
        path=>"/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:/bin:/sbin",
        logoutput=>"on_failure",
    }
    file{"/etc/keystone/keystone.conf":
        ensure=>present,
        source=>"puppet:///modules/keystone/keystone.conf",
        require=>Class["keystone::install"],
    }
    exec{"add":
        command=>"su -s /bin/sh -c \"keystone-manage db_sync\" keystone",
        require=>File["/etc/keystone/keystone.conf"],
        notify=>Exec["init"],
    }
    exec{"init":
        command=>"keystone-manage fernet_setup --keystone-user keystone --keystone-group keystone",
        require=>Exec["add"],
    }
}
