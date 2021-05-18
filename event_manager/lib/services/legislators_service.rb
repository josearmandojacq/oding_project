# frozen_string_literal: true

class LegislatorsService
  def self.call(civic_client, zip)
    new(civic_client, zip).legislators_by_zipcode
  end

  def legislators_by_zipcode
    client.representative_info_by_address(
      address: zip,
      levels: 'country',
      roles: %w[legislatorUpperBody legislatorLowerBody]
    ).officials
  rescue StandardError
    'You can find your representatives by visiting www.commoncause.org/take-action/find-elected-officials'
  end

  private

  attr_reader :zip, :client

  def initialize(civic_client, zip)
    @client = civic_client
    @zip = clean_zipcode(zip)
  end

  def clean_zipcode(zipcode)
    zipcode.to_s.rjust(5, '0')[0..4]
  end
end
