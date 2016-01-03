# coding: UTF-8

require 'rest-client'

class GehirnDNS
  def initialize(token:, secret:)
    @endpoint = "https://#{token}:#{secret}@cp.gehirn.jp/api/dns"
  end

  def domains
    request = RestClient.get("#{@endpoint}/domain")
    result = JSON.parse(request.to_str)

    result["Domain"].collect do |domain|
      GehirnDNS::Domain.new(domain["ID"], domain["Name"])
    end
  end

  def get_resources(domain)
    request = RestClient.get("#{@endpoint}/resource/#{domain.id}")
    result = JSON.parse(request.to_str)
    # domain.resources += result
  end

  def create_a(domain, hostname, ip, ttl)
    params = {
      "Resource": {
        "HostName": hostname,
        "IPAddress": ip,
        "TTL": ttl,
        "Type": "A"
      }
    }
    request = RestClient.post("#{@endpoint}/resource/#{domain.id}", params)
    result = JSON.parse(request.to_str)

    return result["is_success"]
  end
end

class GehirnDNS::Domain
  @resources = []

  def initialize(id, name)
    @id = id
    @name = name
  end

  attr_reader :id, :name
  attr_accessor :resources
end
