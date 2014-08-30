module Puppet::Parser::Functions
  newfunction(:get_zkQuorum,:type => :rvalue) do |args|
    if args.size != 1
      raise(Puppet::ParseError, "get_zkQuorum(): 1 args required)")
    end
    isFirst = 1
    quorum = ""
    zkHosts = args[0]
    
    zkHosts.each do |server,hostname|
      nodename = hostname.split(":")[0]
      if isFirst == 1
        quorum = quorum + "#{nodename}"
        isFirst = 0
      else
        quorum = quorum + ",#{nodename}"
      end
    end
    quorum
  end
end
