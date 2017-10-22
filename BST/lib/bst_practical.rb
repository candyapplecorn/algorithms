require_relative 'binary_search_tree'

def kth_largest(tree_node, k, arr = [])
					# Walk all the way to the rightmost (largest) node
					ret = kth_largest(tree_node.right, k, arr) if tree_node.right

					# If the return value isn't nil, it's the kth largest
					return ret unless ret.nil?

					# Push a pointer to the current node; it's now in a series
					# of the largest elements.
					arr.unshift tree_node

					# If the array has k elements, we can return arr.first
					# space complexity: n
					return arr.first if arr.length == k

					# finally, check the left (smaller) subtrees
					return kth_largest(tree_node.left, k, arr) if tree_node.left
end
