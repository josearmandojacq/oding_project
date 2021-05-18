# frozen_string_literal: true

class TelephoneNumberService
  def self.call(phone_number)
    new(phone_number).clean_phone_number
  end

  def clean_phone_number
    return 'No phone number' if number.nil?

    phone_number = number.gsub(/[^0-9]/, '')

    return 'Bad number' unless phone_number.size.between?(10, 11)

    form_phone_number(phone_number, phone_number.length)
  end

  private

  attr_reader :number

  def initialize(phone_number)
    @number = phone_number
  end

  def form_phone_number(phone_number, size)
    if size == 11
      phone_number = phone_number[0] == '1' ? phone_number[1..11] : 'Bad number'
    end

    phone_number.match?(/[0-9]/) ? "(#{phone_number[0..2]}) #{phone_number[3..5]}-#{phone_number[6..10]}" : phone_number
  end
end
