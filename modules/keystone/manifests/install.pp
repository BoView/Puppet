class keystone::install{
    #package{"keystone":
    #    ensure=>present,
    #    require=>Class["keystone::auth"],
    #    notify=>Package["apache2"],
    #}
    #package{"apache2":
    #    ensure=>present,
    #    require=>Package["keystone"],
    #    notify=>Package["libapache2-mod-wsgi"],
    #}
    #package{"libapache2-mod-wsgi":
    #    ensure=>present,
    #    require=>Package["apache2"],
    #    notify=>Class["keystone::config"],
    #}
    Exec{
        path=>"/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:/bin:/sbin",
        logoutput=>"on_failure",
    }
    exec{"keystone":
        command=>"apt-get install keystone -y --force-yes",
        require=>Class["keystone::auth"],
        notify=>Exec["apache2"],
    }
    exec{"apache2":
        command=>"apt-get install apache2 -y --force-yes",
        require=>Exec["keystone"],
        notify=>Exec["libapache2-mod-wsgi"],
    }
    exec{"libapache2-mod-wsgi":
        command=>"apt-get install libapache2-mod-wsgi -y --force-yes",
        require=>Exec["apache2"],
        notify=>Class["keystone::config"],
    }
}
