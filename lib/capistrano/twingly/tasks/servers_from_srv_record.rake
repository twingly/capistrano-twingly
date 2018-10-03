require 'resolv'

SRV_RECORDS = %w[
  _rubyapps._tcp.live.lkp.primelabs.se
  _rubyapps._tcp.sth.twingly.network
]

resolver = Resolv::DNS.new

servers = SRV_RECORDS.map do |srv_record|
  resolver.getresources(srv_record, Resolv::DNS::Resource::IN::SRV)
end.flatten.map(&:target).map(&:to_s)

raise "Can't find any servers, no records for #{SRV_RECORDS}" if servers.empty?

set :servers_from_srv_record, servers

namespace :list do
  desc 'List servers from SRV records'
  task :servers do
    servers.each { |server| puts server }
  end
end
