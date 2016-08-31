class keystone::verify{
    Exec{
        path=>"/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:/bin:/sbin",
        logoutput=>"on_failure",
    }
    file{"/etc/keystone/keystone-paste.ini":
        ensure=>present,
        source=>"puppet:///modules/keystone/keystone-paste.ini",
    #    require=>Class["keystone::apache2"],
    }
}
