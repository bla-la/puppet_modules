module Puppet::Parser::Functions
     newfunction(:get_myid,:type => :rvalue) do |args|
        if args.size != 2
            raise(Puppet::ParseError, "get_myid(): 2 args required)")
        end
        myId = -1
        zkHosts = args[1]
        nodeFqdn = args[0]
        zkHosts.each do |server,hostname|
            nodename = hostname.split(":")[0]
            id = server.split(".")[1]
            if nodeFqdn == nodename
                myId = id
                puts "Find zookeeper myid for host:#{hostname}, myid is:#{id}"
                break
            end
            puts "==#{hostname} #{nodename} #{id}"
        end
        myId
     end
end
