class mysql::install{
    Exec{
        path=>"/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:/bin:/sbin",
        logoutput=>"on_failure",
    }
    package{"mariadb-server":
        ensure=>present,
        require=>Class["openstack_repository"],
        notify=>Package["python-pymysql"],
    }
    package{"python-pymysql":
        ensure=>present,
        require=>Package["mariadb-server"],
        notify=>Exec["update_passwd"],
    }
    exec{"update_passwd":
        command=>"mysql -uroot -e \"set password for root@localhost = password('root');\"",
        require=>Package["python-pymysql"],
        notify=>Exec["use"],
    }
    exec{"use":
        command=>"mysql -uroot -proot -e \"FLUSH PRIVILEGES;\"",
        require=>Exec["update_passwd"],
        notify=>Exec["exit"],
    }
    exec{"exit":
        command=>"mysql -uroot -proot -e \"exit\"",
        require=>Exec["use"],
    }
}
