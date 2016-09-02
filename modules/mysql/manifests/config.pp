class mysql::config{
    #file{"/etc/mysql/conf.d/openstack.cnf":
    #    ensure=>present,
    #    source=>"puppet:///modules/mysql/openstack.cnf",
    #    require=>Class["mysql::install"],
    #    notify=>Class["mysql::service"],
    #}
    define file($ip){
        file{"/etc/mysql/conf.d/openstack.cnf":
            ensure=>present,
            content=>template("mysql/openstack.cnf.erb"),
            require=>Class["mysql::install"],
            notify=>Class["mysql::service"],
        }
    }
}
