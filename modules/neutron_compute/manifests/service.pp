class neutron_compute::service{
    Exec{
        path=>"/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:/bin:/sbin",
        logoutput=>"on_failure",
    }
    exec{"neutron-nova-compute":
        command=>"service nova-compute restart",
        require=>Class["neutron_compute::config"],
        notify=>Service["neutron-linuxbridge-agent"],
    }
    service{"neutron-linuxbridge-agent":
        ensure=>running,
        hasstatus=>true,
        hasrestart=>true,
        enable=>true,
        require=>Exec["neutron-nova-compute"],
    }
}
