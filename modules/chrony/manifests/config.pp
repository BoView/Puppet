class chrony::config{
    #file{"/etc/chrony/chrony.conf":
    #    ensure=>present,
    #    source=>"puppet:///modules/chrony/chrony.conf",
    #    require=>Class["chrony::install"],
    #    notify=>Class["chrony::service"],
    #}
    define file($controller){
        file{"/etc/chrony/chrony.conf":
            ensure=>present,
            content=>template("chrony/chrony.conf.erb"),
            require=>Class["chrony::install"],
            notify=>Class["chrony::service"],
        }
    }
}
