class dashboard{
    Exec{
        path=>"/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:/bin:/sbin",
        logoutput=>"on_failure",
    }
    exec{"openstack-dashboard":
        command=>"apt-get install openstack-dashboard -y --force-yes",
        require=>Class["neutron"],
        notify=>File["/etc/openstack-dashboard/local_settings.py"],
    }
    define file($controller){
        file{"/etc/openstack-dashboard/local_settings.py":
            ensure=>present,
            content=>template("dashboard/local_settings.py.erb"),
            require=>Exec["openstack-dashboard"],
            notify=>Exec["dashboard-apache2"],
        }
    }
    exec{"dashboard-apache2":
        command=>"service apache2 restart",
        require=>File["/etc/openstack-dashboard/local_settings.py"],
    }
}
