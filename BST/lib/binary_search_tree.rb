require 'byebug'
# There are many ways to implement these methods, feel free to add arguments 
# to methods as you see fit, or to create helper methods.
require_relative 'bst_node'

class BinarySearchTree
	attr_reader :root
  def initialize
					@root = nil
  end

  def insert(value, walk = @root)
					return set_root(value) unless @root

					if walk.value > value
									if walk.left
													return insert(value, walk.left)
									end

									walk.left = BSTNode.new(value)
									return walk.left
					end

					if walk.right
									return insert(value, walk.right)
					end

					walk.right = BSTNode.new(value)
  end

  def find(value, tree_node = @root)
					return nil unless tree_node
					return tree_node if tree_node.value == value
					return tree_node.value > value ? find(value, tree_node.left) :
																					 find(value, tree_node.right)
  end

	def find_parent(target, tree_node = @root)
					return nil unless tree_node
					return tree_node if [
									tree_node, tree_node.left, tree_node.right
					].any? {|n| n == target }

					return tree_node.value > target.value ? 
									find_parent(target, tree_node.left) :
									find_parent(target, tree_node.right)
	end

  def delete(value)
					# find the node containing the value, and its parent
					return nil unless (delete_node = find(value))

					parent = find_parent(delete_node)

					# no children? then remove from tree.
					if no_children? delete_node
									return (@root = nil) if delete_node == @root

									if parent.left == delete_node
													parent.left = nil
									elsif parent.right == delete_node
													parent.right = nil
									end

									return delete_node
					end

					# if no left sub tree of deletenode, make its parents
					# right point to deletenode right
					return parent.right = delete_node.right if delete_node.left.nil?

					# Assume we're deleting 3 from prefilled BST.
					# find the maximum value of its left tree (2)
					walk = maximum(delete_node.left)
					prev = find_parent(walk)
					
					# swap the two values
					# swap 3 with 2
					delete_node.value, walk.value = [walk.value, delete_node.value]
					# make 1's right = 2's (now 3's) left
					prev.right = walk.left
  end

  # helper method for #delete:
  def maximum(tree_node = @root)
					return tree_node.right ? maximum(tree_node.right) : tree_node
  end

  def depth(tree_node = @root, count = 0)
					[tree_node.left, tree_node.right] 	# get the children
					.select{|n| !!n}										# reject nils
					.map{|n| depth(n, count + 1) }			# get children counts
					.concat([count])										# add count in case both nil
					.max																# and get the max
  end 

  def is_balanced?(tree_node = @root)
					return true if !tree_node or no_children? tree_node
					# 1. find the first gap (missing left or right)

					list = [tree_node.left, tree_node.right]
					count = 1
					while 2 ** count == list.length
									list = list
									.reject{|n| n.nil?}
									.map{|st| [st.left, st.right]}
									.flatten
									count += 1
					end
					# 2. find its depth
					# 3 if its depth != maxdepth, is not baalnced!
					depth + 1 == count
  end

  def in_order_traversal(tree_node = @root, arr = [])
					if tree_node.left
									in_order_traversal(tree_node.left, arr)
					end
					arr << tree_node.value
					if tree_node.right
									in_order_traversal(tree_node.right, arr)
					end
					arr
  end


  private
  # optional helper methods go here:

	def set_root(value)
		@root = BSTNode.new(value)
	end

	def no_children?(node)
		node.left.nil? && node.right.nil?
	end
end
