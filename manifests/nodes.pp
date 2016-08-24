node 'controller.openstack.com'{
    file{"/tmp/t.txt":
        content=>"hello\nworld\n"
    }
}
node 'compute.openstack.com'{
    file{"/tmp/t.txt":
        content=>"hello\nworld\n"
    }
}
