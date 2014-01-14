require 'resolv'

resolver = Resolv::DNS.new
resources = resolver.getresources(
  '_rubyapps._tcp.live.lkp.primelabs.se',
  Resolv::DNS::Resource::IN::SRV)
servers = resources.map(&:target).map(&:to_s)

set :servers_from_srv_record, servers
