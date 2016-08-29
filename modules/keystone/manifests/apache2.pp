class keystone::apache2{
    Exec{
        path=>"/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:/bin:/sbin",
        logoutput=>"on_failure",
    }
    file{"/etc/apache2/apache2.conf":
        ensure=>present,
        source=>"puppet:///modules/keystone/apache2.conf",
        require=>Class["keystone::config"],
    }
    file{"/etc/apache2/sites-available/wsgi-keystone.conf":
        ensure=>present,
        source=>"puppet:///modules/keystone/wsgi-keystone.conf",
        require=>File["/etc/apache2/apache2.conf"],
    }
    exec{"ln":
        command=>"ln -s /etc/apache2/sites-available/wsgi-keystone.conf /etc/apache2/sites-enabled",
        require=>File["/etc/apache2/sites-available/wsgi-keystone.conf"],
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
    }
}
