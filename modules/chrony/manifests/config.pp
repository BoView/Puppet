class chrony::config{
    file{"/etc/chrony/chrony.conf":
        ensure=>present,
        source=>"puppet:///modules/chrony/chrony.conf",
        require=>Class["chrony::install"],
        notify=>Class["chrony::service"],
    }
}
