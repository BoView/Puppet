class glance::config{
    Exec{
        path=>"/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:/bin:/sbin",
        logoutput=>"on_failure",
    }
    define file($controller,$passwd){
	file{"/etc/glance/glance-api.conf":
            ensure=>present,
            content=>template("glance/glance-api.conf.erb"),
            require=>Class["glance::install"],
            notify=>File["/etc/glance/glance-registry.conf"],
	}
	file{"/etc/glance/glance-registry.conf":
            ensure=>present,
            content=>template("glance/glance-registry.conf.erb"),
            require=>File["/etc/glance/glance-api.conf"],
            notify=>Exec["sync"],
	}
    }
    exec{"sync":
	command=>"su -s /bin/sh -c \"glance-manage db_sync\" glance",
	require=>File["/etc/glance/glance-registry.conf"],
	notify=>Service["glance-registry"],
    }
    service{"glance-registry":
        ensure=>running,
        hasstatus=>true,
        hasrestart=>true,
        enable=>true,
        require=>Exec["sync"],
        notify=>Service["glance-api"],
    }
    service{"glance-api":
        ensure=>running,
        hasstatus=>true,
	hasrestart=>true,
	enable=>true,
	require=>Service["glance-registry"],
        notify=>Class["nova_controller"],
    }
}