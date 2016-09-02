class base{
    include chrony,openstack_repository
}
node 'controller.openstack.com'{
    include base
    include  mysql,rabbitmq,memcached,keystone
    #include glance
    mysql::conf::file{"bind-address":
        ip=>"192.168.1.7"
    }
    memcached::config::file{"l":
        ip=>"192.168.1.7"
    }
    keystone::config::file{"keystone":
        admin_token=>"e38844a1b84c2d7297ae",
        passwd=>"root",
    }
}

node 'compute.openstack.com'{
    #include base
}

node 'ctrl1.openstack.com'{
    include chrony
    chrony::config::file{"chrony":
        controller=>"ctrl1",
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
