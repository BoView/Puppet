class keystone::create{
    Exec{
        path=>"/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:/bin:/sbin",
        logoutput=>"on_failure",
    }
    exec{"export":
        command=>"export OS_URL=http://192.168.1.7:35357/v3",
    #    require=>Class["keystone::apache2"],
    }
}
