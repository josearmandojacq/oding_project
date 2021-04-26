# frozen_string_literal: true

require "byebug"

class CaesarEncrypt
  def self.call(text, factor)
    new(text, factor).encrypt
  end

  def encrypt
    encrypted_text = ''

    text.each_char do |letter|
      if letter? letter
        encrypted_text += encrypt_upper_case(letter) if upper_case?(letter)
        encrypted_text += encrypt_lower_case(letter) if down_case?(letter)
        next
      end
      encrypted_text += letter
    end

    encrypted_text
  end

  private

  attr_reader :factor, :text

  def initialize(text, factor)
    @text = text
    @factor = factor
  end

  def upper_case?(letter)
    letter == letter.upcase
  end

  def down_case?(letter)
    letter == letter.downcase
  end

  def letter?(letter)
    letter.match?(/[[:alpha:]]/)
  end

  def encrypt_upper_case(letter)
    ((((letter.ord - 65) + factor) % 26) + 65).chr
  end

  def encrypt_lower_case(letter)
    ((((letter.ord - 97) + factor) % 26) + 97).chr
  end
end


p CaesarEncrypt.call('What a string!', 5)
