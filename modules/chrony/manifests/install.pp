class chrony::install{
    file{"/etc/apt/sources.list":
        ensure=>present,
        source=>"puppet:///modules/chrony/sources.list",
        notify=>Exec["sources update"],
    }
    exec{"sources update":
        path=>"/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:/bin:/sbin",
        command=>"apt-get update",
        logoutput=>"on_failure",
        require=>File["/etc/apt/sources.list"],
        notify=>File["/etc/apt/apt.conf"],
    }
    file{"/etc/apt/apt.conf":
        ensure=>present,
        content=>template("chrony/apt.conf.erb"),
        require=>Exec["sources update"],
        notify=>Exec["chrony"],
    }
    exec{"chrony":
        path=>"/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:/bin:/sbin",
        command=>"apt-get install chrony -y --force-yes",
        logoutput=>"on_failure",
        require=>File["/etc/apt/apt.conf"],
        notify=>Class["chrony::config"],
    }
}
