class openstack_repository{
    Exec{
        path=>"/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:/bin:/sbin",
        logoutput=>"on_failure",
    }
    exec{"software-properties-common":
        command=>"apt-get install software-properties-common -y --force-yes",
        require=>Class["chrony"],
        notify=>Class["mysql"],
    }
    #package{"python-openstackclient":
    #    ensure=>present,
    #    require=>Package["software-properties-common"],
    #    notify=>Class["mysql"],
    #}
    #package{"software-properties-common":
    #    ensure=>present,
    #}
    #exec{"add mitaka":
    #    command=>"add-apt-repository cloud-archive:mitaka",
    #    require=>Package["software-properties-common","python-openstackclient"],
    #    notify=>File["/etc/apt/sources.list.d/cloudarchive-mitaka.list"],
    #}
    #file{"/etc/apt/sources.list.d/cloudarchive-mitaka.list":
    #    ensure=>present,
    #    source=>"puppet:///modules/openstack_repository/cloudarchive-mitaka.list",
    #    require=>Exec["add mitaka"],
    #    notify=>Exec["update source"],
    #}
    #exec{"update source":
    #    command=>"apt-get update",
    #    require=>File["/etc/apt/sources.list.d/cloudarchive-mitaka.list"],
    #    notify=>Exec["upgrade"],
    #}
    #exec{"upgrade":
    #    command=>"apt-get dist-upgrade -y",
    #    require=>Exec["update"],
    #    notify=>Class["mysql"],
    #}
}
