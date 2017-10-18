require_relative 'p05_hash_map'
require 'byebug'

def can_string_be_palindrome?(string) 
				myHash = HashMap.new
				string.chars.each do |c|
								if myHash.include? c
												val = myHash.get(c)
												myHash.set(c, val + 1)
								else
												myHash.set(c, 1)
								end
				end

				oneCount = myHash.select { |k| 
								myHash.get(k.first) % 2 != 0 
				}

				twoCount = myHash.select {|node| 
								myHash.get(node.first) % 2 == 0 
				}

				oneCount.length <= 1
end
