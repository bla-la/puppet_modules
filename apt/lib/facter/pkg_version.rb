if  FileTest.exists?("/usr/bin/dpkg-query")
    pkgs = %x{dpkg -l| awk '{ print $2"," $3 }'}
    pkgs.each_line do |line|
        t = line.tr("\n","").split(',')
        Facter.add("pkg_version_#{t[0]}") do
            setcode do
                "#{t[1]}"
            end
        end
    end
end
