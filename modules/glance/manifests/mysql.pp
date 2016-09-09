class glance::mysql{
    Exec{
        path=>"/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:/bin:/sbin",
        logoutput=>"on_failure",
    }
    exec{"create glance":
	command=>"mysql -uroot -proot -e \"CREATE DATABASE glance;\"",
        require=>Class["keystone"],
	notify=>Exec["power1"],
    }
    exec{"power1":
        command=>"mysql -uroot -proot -e \"GRANT ALL PRIVILEGES ON glance.* TO 'glance'@'localhost' IDENTIFIED BY 'root';\"",
	require=>Exec["create glance"],
	notify=>Exec["power2"],
    }
    exec{"power2":
	command=>"mysql -uroot -proot -e \"GRANT ALL PRIVILEGES ON glance.* TO 'glance'@'%' IDENTIFIED BY 'root';\"",
	require=>Exec["power1"],
	notify=>Class["glance::install"],
    }
}
