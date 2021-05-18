# frozen_string_literal: true

require 'google/apis/civicinfo_v2'

class GoogleApi
  def self.civic_info
    civic_info = Google::Apis::CivicinfoV2::CivicInfoService.new
    civic_info.key = 'AIzaSyClRzDqDh5MsXwnCWi0kOiiBivP6JsSyBw'

    civic_info
  end
end
