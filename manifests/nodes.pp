class base{
    include chrony,openstack_repository
}
node 'controller.openstack.com'{
    #include base
    #include  mysql,rabbitmq,memcached,keystone
    include glance
}
node 'compute.openstack.com'{
    #include base
}
