class keystone::apache2{
    Exec{
        path=>"/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:/bin:/sbin",
        logoutput=>"on_failure",
    }
    define file($controller){
        file{"/etc/apache2/apache2.conf":
            ensure=>present,
            content=>template("keystone/apache2.conf.erb"),
            require=>Class["keystone::config"],
            notify=>File["/etc/apache2/sites-available/wsgi-keystone.conf"],
        }
    }
    file{"/etc/apache2/sites-available/wsgi-keystone.conf":
        ensure=>present,
        source=>"puppet:///modules/keystone/wsgi-keystone.conf",
        require=>File["/etc/apache2/apache2.conf"],
        notify=>Exec["ln"],
    }
    exec{"ln":
        command=>"ln -s /etc/apache2/sites-available/wsgi-keystone.conf /etc/apache2/sites-enabled",
        require=>File["/etc/apache2/sites-available/wsgi-keystone.conf"],
        notify=>Service["apache2"],
    }
    service{"apache2":
        ensure=>running,
        hasstatus=>true,
        hasrestart=>true,
        enable=>true,
        require=>Exec["ln"],
        notify=>Exec["rm"],
    }
    exec{"rm":
        command=>"rm -f /var/lib/keystone/keystone.db",
        require=>Service["apache2"],
        notify=>Class["glance"],
    }
}
