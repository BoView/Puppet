class chrony::config{
    define file($controller,$compute){
        file{"/etc/chrony/chrony.conf":
            ensure=>present,
            content=>template("chrony/chrony.conf.erb"),
            require=>Class["chrony::install"],
            notify=>Class["chrony::service"],
        }
    }
}
