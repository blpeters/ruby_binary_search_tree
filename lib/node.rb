# frozen_string_literal: true

# Creates nodes that will make up the Binary Search Tree in tree.rb
class Node
  include Comparable
  attr_reader :data

  def <=>(other)
    data <=> other.data
  end

  def initialize(data = nil, left_child = nil, right_child = nil)
    @data = data
    @left_child = left_child
    @right_child = right_child
  end
end

n1 = Node.new(10, 0, 0)
n2 = Node.new(5, 0, 0)

puts n1 > n2
puts n1 < n2
