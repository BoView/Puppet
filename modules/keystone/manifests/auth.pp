class keystone::auth{
    Exec{
        path=>"/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:/bin:/sbin",
        logoutput=>"on_failure",
    }
    exec{"create keystone":
        command=>"mysql -uroot -proot -e \"create database keystone;\"",
    }
    exec{"user1":
        command=>"mysql -uroot -proot -e \"GRANT ALL PRIVILEGES ON keystone.* TO 'keystone'@'localhost' IDENTIFIED BY 'root';\"",
        require=>Exec["create keystone"],
        notify=>Exec["user2"],
    }
    exec{"user2":
        command=>"mysql -uroot -proot -e \"GRANT ALL PRIVILEGES ON keystone.* TO 'keystone'@'%' IDENTIFIED BY 'root';\"",
        require=>Exec["user1"],
        notify=>Exec["update"],
    }
    exec{"update":
        command=>"mysql -uroot -proot -e \"FLUSH PRIVILEGES;\"",
        require=>Exec["user2"],
        notify=>Exec["forbid start"],
    }
    exec{"forbid start":
        command=>"echo \"manual\" > /etc/init/keystone.override",
        creates=>"/etc/init/keystone.override",
        require=>Exec["update"],
    }
}
