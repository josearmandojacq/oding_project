# frozen_string_literal: true

class Substrings
  def self.call(words, dictionary)
    new(words, dictionary).substrings
  end

  def substrings
    dictionary.each_with_object(Hash.new(0)) do |word, result|
      result[word] += 1 if words.match?(/#{word}/i)
    end
  end

  private

  attr_reader :words, :dictionary

  def initialize(words, dictionary)
    @words = words
    @dictionary = dictionary
  end
end


dictionary = %w[below down go going horn how howdy it i low own part partner sit]
p Substrings.call("Howdy partner, sit down! How's it going?", dictionary)
