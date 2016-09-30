class neutron_compute::install{
    Exec{
        path=>"/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:/bin:/sbin",
        logoutput=>"on_failure",
    }
    exec{"neutron_compute_install":
        command=>"apt-get install neutron-linuxbridge-agent -y --force-yes",
        require=>Class["nova_compute"],
        notify=>Class["neutron_compute::config"],
    }
}
