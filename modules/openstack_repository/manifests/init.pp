class openstack_repository{
    Exec{
        path=>"/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:/bin:/sbin",
        logoutput=>"on_failure",
    }
    package{
        ["software-properties-common","python-openstackclient"]:
        ensure=>present,
    }
    exec{"add":
        command=>"add-apt-repository cloud-archive:mitaka",
        require=>Package["software-properties-common","python-openstackclient"],
        notify=>File["/etc/apt/sources.list.d/cloudarchive-mitaka.list"],
    }
    file{"/etc/apt/sources.list.d/cloudarchive-mitaka.list":
        ensure=>present,
        source=>"puppet:///modules/openstack_repository/cloudarchive-mitaka.list",
        require=>Exec["add"],
        notify=>Exec["update"],
    }
    exec{"update":
        command=>"apt-get update",
        require=>File["/etc/apt/sources.list.d/cloudarchive-mitaka.list"],
        notify=>Exec["upgrade"],
    }
    exec{"upgrade":
        command=>"apt-get dist-upgrade -y",
        require=>Exec["update"],
    }
}
