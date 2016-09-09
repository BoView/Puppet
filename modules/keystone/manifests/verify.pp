class keystone::verify{
    file{"/etc/keystone/keystone-paste.ini":
        ensure=>present,
        source=>"puppet:///modules/keystone/keystone-paste.ini",
        require=>Class["keystone::apache2"],
        notify=>Class["glance"],
    }
}
