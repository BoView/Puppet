class keystone::install{
    package{
        ["keystone","apache2","libapache2-mod-wsgi"]:
        ensure=>present,
        require=>Class["keystone::auth"],
    }
}
