class mysql::config{
    define file($ip){
        file{"/etc/mysql/conf.d/openstack.cnf":
            ensure=>present,
            content=>template("mysql/openstack.cnf.erb"),
            require=>Class["mysql::install"],
            notify=>Class["mysql::service"],
        }
    }
}
