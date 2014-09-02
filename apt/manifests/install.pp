define apt::install($version=undef)
{
    $PKG = ""
    $PKG_VER = get_apt_version("${name}")

    notice("### apt check pkg ${name}")
    if $PKG_VER == undef {
        if $version == undef {
            exec{"apt-install-${name}":
                command => "apt-get install -y --force-yes ${name}",
                path    => "/usr/bin/:/bin:/usr/sbin:/sbin",
                require => Exec["apt-update"]
                }
        } else {
            exec{"apt-install-${name}":
		environment => ["DEBIAN_FRONTEND=noninteractive"],
                command => "apt-get install -y ${name}=${version}",
                path    => "/usr/bin/:/bin:/usr/sbin:/sbin",
                require => Exec["apt-update"]
                }
        }
    } else {
        if $version != undef {
            if $version != $PKG_VER {
                notice("###check package ${name} version $version")
                exec{"apt-install-${name}":
                    command => "apt-get install -y ${name}=${version}",
                    path    => "/usr/bin/:/bin:/usr/sbin:/sbin",
                    require => Exec["apt-update"]
                }
            }
        }
    }



}
