class neutron_compute::config{
    Exec{
        path=>"/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:/bin:/sbin",
        logoutput=>"on_failure",
    }
    define file($ip,$controller,$passwd){
        file{"/etc/neutron/neutron.conf":
            ensure=>present,
            content=>template("neutron_compute/neutron.conf.erb"),
            require=>Class["neutron_compute::install"],
            notify=>File["/etc/neutron/plugins/ml2/linuxbridge_agent.ini"],
        }
        file{"/etc/neutron/plugins/ml2/linuxbridge_agent.ini":
            ensure=>present,
            content=>template("neutron_compute/linuxbridge_agent.ini.erb"),
            require=>File["/etc/neutron/neutron.conf"],
            notify=>Class["neutron_compute::service"],
        }
    }
}
