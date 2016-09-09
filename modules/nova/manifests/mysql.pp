class nova::mysql{
    Exec{
        path=>"/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:/bin:/sbin",
        logoutput=>"on_failure",
    }
    exec{"create nova_api":
        command=>"mysql -uroot -proot -e \"create database nova_api;\"",
        require=>Class["glance"],
        notify=>Exec["create nova"],
    }
    exec{"create nova":
        command=>"mysql -uroot -proot -e \"create database nova;\"",
        require=>Exec["create nova_api"],
        notify=>Exec["nova_power1"],
    }
    exec{"nova_power1":
        command=>"mysql -uroot -proot -e \"GRANT ALL PRIVILEGES ON nova_api.* TO 'nova'@'localhost' IDENTIFIED BY 'root';\"",
        require=>Exec["create nova"],
        notify=>Exec["nova_power2"],
    }
    exec{"nova_power2":
        command=>"mysql -uroot -proot -e \"GRANT ALL PRIVILEGES ON nova_api.* TO 'nova'@'%' IDENTIFIED BY 'root';\"",
        require=>Exec["nova_power1"],
        notify=>Exec["nova_power3"],
    }
    exec{"nova_power3":
        command=>"mysql -uroot -proot -e \"GRANT ALL PRIVILEGES ON nova.* TO 'nova'@'localhost' IDENTIFIED BY 'root';\"",
        require=>Exec["nova_power2"],
        notify=>Exec["nova_power4"],
    }
    exec{"nova_power4":
        command=>"mysql -uroot -proot -e \"GRANT ALL PRIVILEGES ON nova.* TO 'nova'@'%' IDENTIFIED BY 'root';\"",
        require=>Exec["nova_power3"],
        notify=>Class["nova::install"],
    }
}
