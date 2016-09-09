class chrony_compute::config{
    define file($controller,$compute){
        file{"/etc/chrony/chrony.conf":
            ensure=>present,
            content=>template("chrony_compute/chrony.conf.erb"),
            require=>Class["chrony_compute::install"],
            notify=>Class["chrony_compute::service"],
        }
    }
}
