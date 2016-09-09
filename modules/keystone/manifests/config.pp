class keystone::config{
    Exec{
        path=>"/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:/bin:/sbin",
        logoutput=>"on_failure",
    }
    define file($admin_token,$passwd,$controller){
        file{"/etc/keystone/keystone.conf":
            ensure=>present,
            content=>template("keystone/keystone.conf.erb"),
            require=>Class["keystone::install"],
            notify=>Exec["add"],
        }
    }
    exec{"add":
        command=>"su -s /bin/sh -c \"keystone-manage db_sync\" keystone",
        require=>File["/etc/keystone/keystone.conf"],
        notify=>Exec["init"],
    }
    exec{"init":
        command=>"keystone-manage fernet_setup --keystone-user keystone --keystone-group keystone",
        require=>Exec["add"],
        notify=>Class["keystone::apache2"],
    }
}
