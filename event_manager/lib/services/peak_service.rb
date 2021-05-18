# frozen_string_literal: true

class PeakService
  def self.call(days:, hours:)
    new(days, hours).peak
  end

  def peak
    peak_days = collect_values(days)
    peak_hours = collect_values(hours)

    puts %(

#### Days are represented with numbers, starting with Sunday as 0 ####

The peak days are #{peak_days[0]}, #{peak_days[1]}, #{peak_days[2]}
----------------------------------------------------------------------

The peak hours are #{peak_hours[0]}, #{peak_hours[1]}, #{peak_hours[2]}
)
  end

  private

  attr_reader :days, :hours

  def initialize(days, hours)
    @days = days
    @hours = hours
  end

  def collect_values(elements)
    elements.tally.max_by(3) { |_k, v| v }.map(&:first).sort
  end
end
