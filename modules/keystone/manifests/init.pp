class keystone{
    include keystone::auth,keystone::install,keystone::config,keystone::apache2
    #include keystone::verify
}
