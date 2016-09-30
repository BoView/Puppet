class neutron::mysql{
    Exec{
        path=>"/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:/bin:/sbin",
        logoutput=>"on_failure",
    }
    exec{"create neutron":
        command=>"mysql -uroot -proot -e \"create database neutron;\"",
        require=>Class["nova"],
        notify=>Exec["neutron_power1"],
    }
    exec{"neutron_power1":
        command=>"mysql -uroot -proot -e \"GRANT ALL PRIVILEGES ON neutron.* TO 'neutron'@'localhost' IDENTIFIED BY 'root';\"",
        require=>Exec["create neutron"],
        notify=>Exec["neutron_power2"],
    }
    exec{"neutron_power2":
        command=>"mysql -uroot -proot -e \"GRANT ALL PRIVILEGES ON neutron.* TO 'neutron'@'%' IDENTIFIED BY 'root';\"",
        require=>Exec["neutron_power1"],
        notify=>Class["neutron::install"],
    }
}
