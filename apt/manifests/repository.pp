define apt::repository($url,
                       $key=nil,
                       $content=nil)
{
    include apt
    $root = $apt::root
    $sources_list_d = $apt::sources_list_d

    if $content  == nil {
        $_content = "deb $url ./"
    }else{
        $_content = $content 
    }


    file { "${name}.list":
        ensure => present,
        path => "$sources_list_d/$name.list",
        owner => root,
        group => root,
        mode => '0644',
        content => $_content,
    #    notify => Exec['apt_update'],
    }

    if $key != nil {
        exec {"add-${name}-key":
            command => "wget -qO - ${key} | sudo apt-key add -",
            path    => "/usr/bin/",
            before => Exec["apt-update"]
        }
    }
}

