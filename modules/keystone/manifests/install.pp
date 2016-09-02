class keystone::install{
    package{"keystone":
        ensure=>present,
        require=>Class["keystone::auth"],
        notify=>Package["apache2"],
    }
    package{"apache2":
        ensure=>present,
        require=>Package["keystone"],
        notify=>Package["libapache2-mod-wsgi"],
    }
    package{"libapache2-mod-wsgi":
        ensure=>present,
        require=>Package["apache2"],
        notify=>Class["keystone::config"],
    }
}
