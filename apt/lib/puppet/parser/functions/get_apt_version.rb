module Puppet::Parser::Functions
     newfunction(:get_apt_version,:type => :rvalue) do |args|
        if args.size != 1
            raise(Puppet::ParseError, "get_apt_version(): 1 args required)")
        end
        pkg_name = args[0]

        lookupvar("pkg_version_#{pkg_name}")
     end
end
