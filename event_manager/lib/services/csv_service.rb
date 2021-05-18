# frozen_string_literal: true

require 'csv'

class CsvService
  def self.open_csv
    CSV.open(
      'event_attendees.csv',
      headers: true,
      header_converters: :symbol
    )
  end
end
