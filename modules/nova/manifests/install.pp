class nova::install{
    Exec{
        path=>"/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:/bin:/sbin",
        logoutput=>"on_failure",
    }
    exec{"nova":
        command=>"apt-get install nova-api nova-conductor nova-consoleauth nova-novncproxy nova-scheduler -y --force-yes",
        require=>Class["nova::mysql"],
        notify=>Class["nova::config"],
    }
}
