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

  def delete(value, root = @root)
    return nil if root == nil
    if value < root.data
      root.left_child = delete(value, root.left_child)
    elsif value > root.data
      root.right_child = delete(value, root.right_child)
    else # This means the value is a match for the root data.
      
      # Case where root has no children
      if root.left_child == nil && root.right_child == nil
        return nil

      # Case where root has one child
      elsif root.left_child == nil
        return root.right_child
      elsif root.right_child == nil
        return root.left_child
      end

      # Case where root has both children
      temp = findInorderSuccessor(root)
      root.data = temp
      root.right_child = delete(temp, root.right_child)
    
    end

    root
  end

  def findInorderSuccessor(node)
    current_node = node.right_child
    while current_node.left_child != nil
      current_node = current_node.left_child
    end
    current_node.data
  end

  def find(value)
    current_node = @root
    until (value == current_node.data || current_node == nil)
      current_node = current_node.left_child if value < current_node.data
      current_node = current_node.right_child if value > current_node.data
    end
    current_node
  end

  def level_order(root = @root)

    # TODO - Can be done with iteration or recursion - DO BOTH!!!

    return nil if root == nil

    result = []
    queue = [root]

    while queue.any? do
      current_node = queue.shift
      block_given? ? yield(current_node) : result.push(current_node.data)
      queue.push(current_node.left_child) if current_node.left_child
      queue.push(current_node.right_child) if current_node.right_child
    end

    result unless block_given?
  end

  def preorder(root = @root, result = [], &block)
    return if root == nil

    block_given? ? yield(root) : result << root.data
    preorder(root.left_child, result, &block)
    preorder(root.right_child, result, &block)

    result unless block_given?
  end
  
  def inorder(root = @root, result = [], &block)
    return if root == nil

    inorder(root.left_child, result, &block)
    block_given? ? yield(root) : result << root.data
    inorder(root.right_child, result, &block)

    result unless block_given?
  end

  def postorder(root = @root, result = [], &block)
    return if root == nil

    postorder(root.left_child, result, &block)
    postorder(root.right_child, result, &block)
    block_given? ? yield(root) : result << root.data

    result unless block_given?
  end

  def height(node)
    return -1 if node == nil

    left = height(node.left_child)
    right = height(node.right_child)
    return 1 + [left, right].max
    
  end

  def depth(node, current_node = @root)
    return 0 if node == current_node

    depth = 0
    while true
      node.data < current_node.data ? current_node = current_node.left_child : current_node = current_node.right_child
      depth += 1
      break if node == current_node
    end
    depth
  end

  def depth_recursive(node, current_node = @root)
    # use steps from the iterative depth function above to make a recursive option.
  end

  def balanced?(root = @root)
    # balanced only if the heights of left subtree and right subtree OF EVERY NODE is not more than 1.
    return true if root == nil || (root.left_child == nil && root.right_child == nil)

    difference = height(root.left_child) - height(root.right_child)
    puts difference
    if [-1,0,1].include?(difference)
      balanced?(root.left_child)
      balanced?(root.right_child)
    else
      puts "failing difference: #{difference}"
      puts "failing root: #{root.data}"
      return false
    end
  end

  def rebalance
    new_ordered_arr = inorder
    p new_ordered_arr
    @root = build_tree(new_ordered_arr, 0, new_ordered_arr.length - 1)
  end
end

node_it = Proc.new {|node| puts "it's node #{node.data}"}

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
tree.pretty_print
tree.delete(324)
tree.pretty_print
tree.find(6345)
tree.level_order do |node|
   puts "current data: #{node.data}"
end
p tree.preorder
p tree.inorder
p tree.postorder
puts tree.height(tree.find(6345))
puts tree.height(tree.find(8))
puts tree.depth(tree.find(6345))
puts tree.depth(tree.find(8))
puts tree.depth(tree.find(310))
puts tree.depth(tree.find(311))
puts tree.balanced?
tree.pretty_print
tree.rebalance
tree.pretty_print
puts tree.balanced?


