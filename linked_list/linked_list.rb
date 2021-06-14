# frozen_string_literal: true

require_relative 'node'
require 'byebug'

class LinkedList
  attr_reader :head

  def initialize
    @head = nil
  end

  def append(value)
    new_node = Node.new(value)

    if head.nil?
      @head = new_node
    else
      last_node = find_last_node
      last_node&.next_node = new_node
    end
  end

  def prepend(value)
    node = Node.new(value)

    return nil if head.nil?

    first_node = head

    @head = node

    head.next_node = first_node
  end

  def size
    node = head
    counter = 0

    until node.nil?
      node = node.next_node
      counter += 1
    end

    counter
  end

  def tail
    find_last_node
  end

  def at(index)
    return head if index.zero?

    counter = 1
    node = head

    until node.nil?
      node = node.next_node
      return node&.value if counter == index

      counter += 1
    end
  end

  def pop
    current_node = head

    if current_node.next_node.nil?
      @head = nil
      return current_node.value
    end

    until current_node.nil?
      if current_node.next_node&.next_node.nil?
        last_node = current_node.next_node
        current_node.next_node = nil
        return last_node&.value
      end

      current_node = current_node.next_node
    end
  end

  def contains?(value)
    return false if head.nil?

    node = head

    until node.nil?
      return true if node.value == value

      node = node.next_node
    end

    false
  end

  def find(value)
    return head if head.nil?

    node = head
    index = 0

    until node.nil?
      return index if node.value == value

      node = node.next_node
      index += 1
    end

    nil
  end

  def to_s
    result = ''

    if head.nil?
      puts 'No value in the list'
      return
    elsif head.next_node.nil?
      result += head.value.to_s
      result += '->'
    else
      node = head

      until node.nil?
        result += node.value.to_s
        result += '->'
        node = node.next_node
      end
    end

    result += 'nil'

    p result
  end

  def insert_at(value, index)
    return if head.nil? || !index.between?(0, size - 1)

    node = head
    counter = 0

    until node.nil?
      if counter + 1 == index
        next_node = node.next_node
        new_node = Node.new(value)
        node.next_node = new_node
        new_node.next_node = next_node
      end
      counter += 1
      node = node.next_node
    end
  end

  def remove_at(index)
    return if head.nil? || !index.between?(0, size - 1)

    node = head
    counter = 0

    until node.nil?
      node.next_node = node.next_node&.next_node if counter + 1 == index

      counter += 1
      node = node.next_node
    end
  end

  private

  def find_last_node
    return head if head.nil? || head.next_node.nil?

    node = head

    node = node.next_node until node.next_node.nil?

    node
  end
end
