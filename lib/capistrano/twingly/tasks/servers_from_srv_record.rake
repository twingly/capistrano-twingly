require 'resolv'

SRV_RECORDS = %w[
  _rubyapps._tcp.sth.twingly.network
]
FALLBACK_DNS_SERVER = "gateway.sth.twingly.network"

def lookup_srv_records(resolver: Resolv::DNS.new)
  SRV_RECORDS.map do |srv_record|
    resolver.getresources(srv_record, Resolv::DNS::Resource::IN::SRV)
  end.flatten.map(&:target).map(&:to_s)
end

servers = lookup_srv_records

# Query datacenter gateway directly if local DNS server is unable to find the SRV records
if servers.empty?
  datacenter_dns_server_address = Resolv.getaddress(FALLBACK_DNS_SERVER)

  resolver = Resolv::DNS.new(nameserver: datacenter_dns_server_address)
  servers  = lookup_srv_records(resolver: resolver)

  raise "Can't find any servers, no records for #{SRV_RECORDS}" if servers.empty?
end

set :servers_from_srv_record, servers

namespace :list do
  desc 'List servers from SRV records'
  task :servers do
    servers.each { |server| puts server }
  end
end
