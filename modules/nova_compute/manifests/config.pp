class nova_compute::config{
    Exec{
        path=>"/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:/bin:/sbin",
        logoutput=>"on_failure",
    }
    define file($ip,$controller,$passwd,$controller_ip){
        file{"/etc/nova/nova.conf":
            ensure=>present,
            content=>template("nova_compute/nova.conf.erb"),
            require=>Class["nova_compute::install"],
            notify=>File["/etc/nova/nova-compute.conf"],
        }
    }
    file{"/etc/nova/nova-compute.conf":
        ensure=>present,
        content=>template("nova_compute/nova-compute.conf.erb"),
        require=>File["/etc/nova/nova.conf"],
        notify=>Service["nova-compute"],
    }
    service{"nova-compute":
        ensure=>running,
        hasstatus=>true,
        hasrestart=>true,
        enable=>true,
        require=>File["/etc/nova/nova-compute.conf"],
        notify=>Class["neutron_compute"],
    }
}
