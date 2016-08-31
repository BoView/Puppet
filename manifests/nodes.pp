class base{
    include chrony,openstack_repository
}
node 'controller.openstack.com'{
    #include base
    #include  mysql,rabbitmq,memcached
    include keystone
}
node 'compute.openstack.com'{
    #include base
}
