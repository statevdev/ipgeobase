# frozen_string_literal: true

require 'happymapper'
require 'net/http'
require 'uri'

require_relative 'ipgeobase/version'

module Ipgeobase
  class Error < StandardError; end

  class Metadata
    include HappyMapper

    tag 'query'
    element :city, String, tag: 'city'
    element :country, String, tag: 'country'
    element :countryCode, String, tag: 'countryCode'
    element :lat, String, tag: 'lat'
    element :lon, String, tag: 'lon'
  end

  def self.lookup(ip_address)
    url = URI.parse("http://ip-api.com/xml/#{ip_address}")
    params = { fields: 'city,country,countryCode,lat,lon' }
    url.query = URI.encode_www_form(params)

    response = Net::HTTP.get(url)

    Metadata.parse(response)
  end
end
