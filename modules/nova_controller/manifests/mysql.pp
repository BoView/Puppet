class nova_controller::mysql{
    Exec{
        path=>"/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:/bin:/sbin",
        logoutput=>"on_failure",
    }
    exec{"create nova_api":
        command=>"mysql -uroot -proot -e \"create database nova_api;\"",
    #    require=>Class["glance"],
        notify=>Exec["create nova"],
    }
    exec{"create nova":
        command=>"mysql -uroot -proot -e \"create database nova;\"",
        require=>Exec["create nova_api"],
        notify=>Exec["power1"],
    }
    exec{"power1":
        command=>"mysql -uroot -proot -e \"GRANT ALL PRIVILEGES ON nova_api.* TO 'nova'@'localhost' IDENTIFIED BY 'root';\"",
        require=>Exec["create nova"],
        notify=>Exec["power2"],
    }
    exec{"power2":
        command=>"mysql -uroot -proot -e \"GRANT ALL PRIVILEGES ON nova_api.* TO 'nova'@'%' IDENTIFIED BY 'root';\"",
        require=>Exec["power1"],
        notify=>Exec["power3"],
    }
    exec{"power3":
        command=>"mysql -uroot -proot -e \"GRANT ALL PRIVILEGES ON nova.* TO 'nova'@'localhost' IDENTIFIED BY 'root';\"",
        require=>Exec["power2"],
        notify=>Exec["power4"],
    }
    exec{"power4":
        command=>"mysql -uroot -proot -e \"GRANT ALL PRIVILEGES ON nova.* TO 'nova'@'%' IDENTIFIED BY 'root';\"",
        require=>Exec["power3"],
        notify=>Class["nova_controller::install"],
    }
}
