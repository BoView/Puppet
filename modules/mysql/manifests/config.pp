class mysql::config{
    file{"/etc/mysql/conf.d/openstack.cnf":
        ensure=>present,
        source=>"puppet:///modules/mysql/openstack.cnf",
        require=>Class["mysql::install"],
        notify=>Class["mysql::service"],
    }
}
