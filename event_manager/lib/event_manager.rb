# frozen_string_literal: true

require 'byebug'
require 'date'
require_relative 'google_api'
require_relative 'services/legislators_service'
require_relative 'services/telephone_number_service'
require_relative 'services/zipcode_service'
require_relative 'services/peak_service'
require_relative 'services/csv_service'
require_relative 'services/form_letter_service'

class EventManager
  attr_reader :civic_info, :contents

  def initialize
    @civic_info = GoogleApi.civic_info
    @contents = CsvService.open_csv
  end

  def start_event
    options = %w[gp pn pk ex]

    puts 'EventManager initialized!'

    puts %(
Options:
gp - Greet Participants
pn - Shows Participants Telephone Number
pk - Show Peak Days and Hours of Voting
ex - Exit
-----------------------------------------
)

    user_input = gets.chomp
    puts "\n"

    exit if user_input == 'ex' || !options.include?(user_input)

    hours = []
    days = []

    contents.each do |row|
      name = row[:first_name]

      case user_input
      when 'pk'
        date = DateTime.strptime(row[:regdate], '%m/%d/%y %H:%M')
        hours << date.hour
        days << date.wday
      when 'gp'
        id = row[0]

        zipcode = ZipcodeService.clean_zipcode(row[:zipcode])
        legislators = LegislatorsService.call(civic_info, zipcode)

        FormLetterService.new(name: name, legislators: legislators).save_letter(id)
      when 'pn'
        phone_number = TelephoneNumberService.call(row[:homephone])

        puts "#{name}-#{phone_number}\n"
      end
    end

    PeakService.call(days: days, hours: hours) if user_input == 'pk'
  end
end
