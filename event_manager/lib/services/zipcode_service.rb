# frozen_string_literal: true

class ZipcodeService
  def self.clean_zipcode(zipcode)
    zipcode.to_s.rjust(5, '0')[0..4]
  end
end
