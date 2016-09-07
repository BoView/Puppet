class chrony::service{
    service{"chrony":
        ensure=>running,
        hasstatus=>true,
        hasrestart=>true,
        enable=>true,
        require=>Class["chrony::config"],
    #    notify=>Class["openstack_repository"],
    }
}
