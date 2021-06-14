# frozen_string_literal: true

class Node
  attr_accessor :next_node
  attr_reader :value

  def initialize(value)
    @value = value
    @next_node = nil
  end
end
