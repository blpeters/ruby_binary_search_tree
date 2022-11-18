# frozen_string_literal: true

require_relative 'node'

# Class that will build a binary search tree using nodes from node.rb
class Tree

  attr_reader :root

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

  # TODO: delete method with the following pseudocode:
  # Node to be deleted is the leaf: Simply remove from the tree.
  # Node to be deleted has only one child: Copy the child to the node and delete the child
  # Node to be deleted has two children: Find inorder successor of the node. 
  # Copy contents of the inorder successor to the node and delete the inorder successor.
  # Note that inorder predecessor can also be used.

  def find(value)
    current_node = @root
    until (value == current_node.data || current_node == nil)
      current_node = current_node.left_child if value < current_node.data
      current_node = current_node.right_child if value > current_node.data
    end
    p current_node
  end

  def level_order(block)
    # should traverse the tree in breadth-firstl level order and yield each
    # node to the provided block.
    # Can be done with iteration or recursion - DO BOTH!!!
    # Return an ARRAY of values if no block is given.
    # Use an array acting as a queue to keep track of all the child nodes 
    # that you have yet to traverse and to add new ones to the list.
  end

  def inorder(block)
    # Each block should traverse the tree in their respective depth-first order
    # and yield each node to the provided block.
    # Return an array of values if no block given.
  end

  def preorder(block)
    # Each block should traverse the tree in their respective depth-first order
    # and yield each node to the provided block.
    # Return an array of values if no block given.
  end

  def postorder(block)
    # Each block should traverse the tree in their respective depth-first order
    # and yield each node to the provided block.
    # Return an array of values if no block given.
  end

  def height(node)
    # accepts a node and returns its height
    # height is defined as the number of edges in longest path from a given node to a leaf node.
    # Basically, How much tree is left?
  end

  def depth(node)
    # accepts a node and returns its depth.
    # depth is defined as the number of edges in path from a given node to the tree's root node.
    # Basically, how far down in the tree are you?
  end

  def balanced?
    # balanced only if the heights of left subtree and right subtree OF EVERY NODE is not more than 1.
  end

  def rebalance
    # rebalances an unbalanced tree
    # Use a traversal method to provide a new array to the build_tree method.
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
# tree.delete(9)
# tree.pretty_print
# tree.delete(300)
# tree.pretty_print
tree.find(6345)
