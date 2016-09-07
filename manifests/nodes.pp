node 'controller.openstack.com'{
    #include chrony
    #chrony::config::file{"chrony":
    #    controller=>"controller",
    #    compute=>"compute",
    #}   
    #include openstack_repository
    #include mysql
    #mysql::config::file{"bind-address":
    #    ip=>"192.168.1.7"
    #}   
    #include rabbitmq
    #include memcached
    #memcached::config::file{"l":
    #    ip=>"192.168.1.7"
    #}   
    #include keystone
    #keystone::config::file{"keystone":
    #    admin_token=>"e38844a1b84c2d7297ae",
    #    passwd=>"root",
    #    controller=>"controller",
    #}
    #include glance
    #glance::config::file{"glance":
    #    controller=>"controller",
    #    passwd=>"root", 
    #}
    include nova_controller
    nova_controller::config::file{"nova":
        ip=>"192.168.1.7",
        controller=>"controller",
        passwd=>"root",
    }
}

node 'compute.openstack.com'{
    include chrony
    chrony::config::file{"chrony":
        controller=>"controller",
        compute=>"compute",
    }
    include nova_compute
    nova_compute::config::file{"nova":
        ip=>"192.168.1.8",
        controller=>"controller",
        passwd=>"root",
    }
}

node 'ctrl1.openstack.com'{
    include chrony
    chrony::config::file{"chrony":
        controller=>"ctrl1",
        compute=>"compute",
    }
    include openstack_repository
    include mysql
    mysql::config::file{"bind-address":
        ip=>"192.168.1.9"
    }
    include rabbitmq
    include memcached
    memcached::config::file{"l":
        ip=>"192.168.1.9"
    }
    include keystone
    keystone::config::file{"keystone":
        admin_token=>"e38844a1b84c2d7297ae",
        passwd=>"root",
        controller=>"ctrl1",
    }
}
