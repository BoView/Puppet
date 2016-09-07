class glance::install{
    Exec{
        path=>"/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:/bin:/sbin",
        logoutput=>"on_failure",
    }
    exec{"glance":
	command=>"apt-get install glance -y --force-yes",
	require=>Class["glance::mysql"],
	notify=>Class["glance::config"],
    }
}
