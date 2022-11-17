# frozen_string_literal: true

require_relative 'node'

# Class that will build a binary search tree using nodes from node.rb
class Tree
  def initialize(arr)
    @arr = clean_array(arr)
    @root = build_tree(@arr, 0, @arr.length - 1)
    pretty_print
  end

  def build_tree(arr, start_index, end_index)
    return nil if start_index > end_index

    middle = (start_index + end_index) / 2
    root = Node.new(arr[middle])
    root.left_child = build_tree(arr, start_index, middle - 1)
    root.right_child = build_tree(arr, middle + 1, end_index)

    root
  end

  def clean_array(unsorted_arr)
    result = unsorted_arr.sort.uniq
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right_child, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right_child
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left_child, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left_child
  end

  def insert(value)
    insert_node = Node.new(value)
    compared_node = @root
    compare_left(insert_node, compared_node) ? return : compare_right(insert_node, compared_node)
  end

  def compare_left(insert_node, compared_node)
    while insert_node.data < compared_node.data do
      if compared_node.left_child == nil
        compared_node.left_child = insert_node
        pretty_print
        return true
      end
      compared_node = compared_node.left_child
    end
    compare_right(insert_node, compared_node) if insert_node.data > compared_node.data
    false
  end

  def compare_right(insert_node, compared_node)
    while insert_node.data > compared_node.data do
      if compared_node.right_child == nil
        compared_node.right_child = insert_node
        pretty_print
        return true
      end
      compared_node = compared_node.right_child
    end
    compare_left(insert_node, compared_node) if insert_node.data < compared_node.data
    false
  end

  def delete(value, compared_node = @root)
    delete_node = Node.new(value)
    if found_value?(delete_node, compared_node)
      if compared_node.right_child == nil
        compared_node = compared_node.left_child
        delete(compared_node.left_child.data, compared_node) unless compared_node == nil
      end
      if compared_node.left_child == nil
        compared_node = compared_node.right_child
        delete(compared_node.right_child.data, compared_node) unless compared_node == nil
      end
      pretty_print
    else
      puts "value does not exist"
    end
  end

  def found_value?(delete_node, compared_node)
    puts "incoming value: #{compared_node.data}"
    until delete_node.data == compared_node.data
      return nil if compared_node.left_child == nil && compared_node.right_child == nil

      delete_node.data < compared_node.data ? compared_node = compared_node.left_child : compared_node = compared_node.right_child
      puts "outgoing value: #{compared_node.data}"
    end
    compared_node
  end

end

tree = Tree.new([1,7,4,23,8,9,4,3,5,7,9,67,6345,324])
tree.insert(0)
tree.insert(-5)
tree.insert(6346)
tree.insert(300)
tree.insert(310)
tree.insert(290)
tree.insert(311)
tree.insert(291)
tree.insert(289)
tree.insert(24)
tree.delete(9)
