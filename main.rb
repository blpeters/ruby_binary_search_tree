# frozen_string_literal: true

require_relative 'lib/node'
require_relative 'lib/tree'

random_arr = Array.new(15) { rand(1..100) }
tree = Tree.new(random_arr)
puts tree.balanced?
p tree.level_order
p tree.preorder
p tree.inorder
p tree.postorder
tree.insert(105)
tree.insert(111)
tree.insert(120)
tree.insert(1000)
puts tree.balanced?
tree.rebalance
puts tree.balanced?
tree.pretty_print
puts "level order: #{tree.level_order}"
puts "preorder: #{tree.preorder}"
puts "inorder: #{tree.inorder}"
puts "postorder: #{tree.postorder}"
