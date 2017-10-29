require 'byebug'

# Total time complexity...
# O(n^2) + O(8n)
# lol....
def trio_sum_zero list
  # probably linear
  indices = (0 ... list.length).to_a

  all_pairs = indices
  .product(indices)                 #quadratic
  .reject{|t| t.uniq.length != 2 }  #linear
  .map(&:sort)                      #linear
  .uniq                             #linear

  # constant
  sum_hash = Hash.new do |h, k|
    h[k] = []
  end

  # A bit longer than linear, since there should be more pairs
  # than the number of items in list.
  all_pairs.map do |tuple|
    sum = list[tuple.first] + list[tuple.last]
    sum_hash[-sum] << tuple
  end

  trio_sums = []

  list.each_with_index do |element, index|  #linear
    unless sum_hash[element].empty?
      trio_sums += sum_hash[element].map{|to| to << index }
    end
  end

  trio_sums
  .reject{|tp| tp.uniq.length != 3} #linear
  .map(&:sort)                      #linear
  .uniq                             #linear
end
