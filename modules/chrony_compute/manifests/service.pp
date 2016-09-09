class chrony_compute::service{
    service{"chrony":
        ensure=>running,
        hasstatus=>true,
        hasrestart=>true,
        enable=>true,
        require=>Class["chrony_compute::config"],
        notify=>Class["nova_compute"],
    }
}
