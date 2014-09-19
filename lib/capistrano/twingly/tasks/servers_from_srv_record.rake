require 'resolv'

SRV_RECORD = '_rubyapps._tcp.live.lkp.primelabs.se'

resolver = Resolv::DNS.new
resources = resolver.getresources(
  SRV_RECORD,
  Resolv::DNS::Resource::IN::SRV)
servers = resources.map(&:target).map(&:to_s)

raise "Can't find any servers, no records for #{SRV_RECORD}" if servers.empty?

set :servers_from_srv_record, servers

namespace :list do
  desc 'List servers from SRV records'
  task :servers do
    servers.each { |server| puts server }
  end
end
