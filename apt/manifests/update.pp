define apt::update()
{
        exec {"apt-update":
            command => "apt-get update",
            path    => "/usr/bin/",
#            require => File['sources.list']
        }
}
