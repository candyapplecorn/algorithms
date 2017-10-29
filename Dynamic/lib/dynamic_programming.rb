require 'byebug'
class DynamicProgramming

  def initialize
			@b_cache = {1 => 1, 2 => 2}
			@c_cache = {
				1 => [ [1] ],
				2 => [ [1, 1], [2] ],
				3 => [ [1, 1, 1], [2, 1], [1, 2], [3] ]
			}
  end

  def blair_nums(n)
			return @b_cache[n] if @b_cache[n] 

			@b_cache[n] = blair_nums(n - 1) + blair_nums(n - 2) + (2 * (n - 2) + 1)
			@b_cache[n]
  end

  def frog_hops_bottom_up(n)
			cache = frog_cache_builder(n)
			cache[n]
  end

  def frog_cache_builder(n)
			c = {
				1 => [ [1] ],
				2 => [ [1, 1], [2] ],
				3 => [ [1, 1, 1], [2, 1], [1, 2], [3] ]
			}

			(4..n).each do |i|
				newList = []

				(1..3).each do |minus|
					sl = c[i - minus]
					newList += sl.map {|l| [minus] + l}
				end

				c[i] = newList
			end

			c
  end

  def frog_hops_top_down(n)
			frog_hops_top_down_helper(n)
  end

  def frog_hops_top_down_helper(n)
			frog_hops_top_down_helper(n - 1) if (n > 1)

			return @c_cache[n] if @c_cache[n]

			newList = []

			(1..3).each do |minus|
				sl = @c_cache[n - minus]
				newList += sl.map {|l| [minus] + l}
			end

			@c_cache[n] = newList
  end

  def super_frog_hops(n, k)
			super_frog_cache_builder(n, k)[n].reject {|sl| sl.find {|i| i > k} }
  end

  def super_frog_cache_builder(n, k)
			c = {
				1 => [ [1] ],
				2 => [ [1, 1], [2] ],
				3 => [ [1, 1, 1], [2, 1], [1, 2], [3] ]
			}

			(4..n).each do |i|
				newList = []

				(1..[i, k].min).each do |minus|
					sl = c[i - minus]
					newList += sl.map {|l| [minus] + l} if sl
				end

				newList << [i] if i <= k
				c[i] = newList
			end

			c
  end

  def knapsack(weights, values, capacity)
		table = knapsack_table(weights, values, capacity)
		table.flatten.max
  end

  # Helper method for bottom-up implementation
  def knapsack_table(weights, values, capacity)
		t = Array.new(weights.length) { Array.new(capacity + 1) } # make a weighs
		weights.length.times {|i| t[i][0] = 0 }										# set 1st column to zeros

		t.each_index do |i|
			t[i].each_index do |j|
				wt_i = weights[i]
				vl_i = values[i]
				prev = t[i - 1][j] || 0

				if j < wt_i																						# The current capacity can't hold the current weight
					t[i][j] = prev																			# So make it the previous column's answer (without wt[i])
				else
					a = vl_i #+ t[i - 1][j - wt_i]												# The current value + the above row minus the current's weight
					if (i - 1 >= 0)
						a += t[i - 1][j - wt_i]
					end

					b = prev																						# The previous
					t[i][j] = [a, b].max
				end
			end
		end
  end

  def maze_solver(maze, start_pos, end_pos)
  end
end

DynamicProgramming.new.knapsack([2, 3, 4], [1, 3, 3], 7)
