class nova_compute::install{
    Exec{
        path=>"/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:/bin:/sbin",
        logoutput=>"on_failure",
    }
    exec{"nova-compute":
        command=>"apt-get install nova-compute -y --force-yes",
        require=>Class["chrony_compute"],
        notify=>Class["nova_compute::config"],
    }
}
