# frozen_string_literal: true

# Creates nodes that will make up the Binary Search Tree in tree.rb
class Node
  include Comparable
  attr_reader :data
  attr_accessor :left_child, :right_child

  def <=>(other)
    data <=> other.data
  end

  def initialize(data, left_child = nil, right_child = nil)
    @data = data
    @left_child = left_child
    @right_child = right_child
  end
end
