# frozen_string_literal: true

require_relative 'test_helper'

class TestIpgeobase < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::Ipgeobase::VERSION
  end

  def test_lookup
    ip_address = '8.8.8.8'
    response_body = response_xml

    url = build_url(ip_address)

    stub_request(:get, url).to_return(body: response_body)

    ip_meta = Ipgeobase.lookup(ip_address)

    assert { ip_meta.city == 'Ashburn' }
    assert { ip_meta.country == 'United States' }
    assert { ip_meta.countryCode == 'US' }
    assert { ip_meta.lat == '39.03' }
    assert { ip_meta.lon == '-77.5' }
  end

  def response_xml
    <<-XML
      <query>
        <city>Ashburn</city>
        <country>United States</country>
        <countryCode>US</countryCode>
        <lat>39.03</lat>
        <lon>-77.5</lon>
      </query>
    XML
  end

  def build_url(ip_address)
    url = URI.parse("http://ip-api.com/xml/#{ip_address}")
    params = { fields: 'city,country,countryCode,lat,lon' }
    url.query = URI.encode_www_form(params)
    url
  end
end
