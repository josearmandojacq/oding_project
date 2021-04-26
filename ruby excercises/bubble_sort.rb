# frozen_string_literal: true

class BubbleSort
  def self.call(array)
    new(array).sort
  end

  def sort
    sorted = true

    while sorted
      sorted = false

      list.each_with_index do |value, index|
        next if index + 1 >= list.length

        next unless value > list[index + 1]

        list[index] = list[index + 1]
        list[index + 1] = value
        sorted = true
      end
    end

    list
  end

  private

  attr_reader :list

  def initialize(array)
    @list = array
  end
end
