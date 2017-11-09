#!/bin/ruby

def solve(a0, a1, a2, b0, b1, b2)
    # Complete this function
    assign = Proc.new {|a, b| a < b ? [0, 1] : a > b ? [1, 0] : [0, 0] }
    
    [[a0, b0], [a1, b1], [a2, b2]].reduce([0, 0]) do |acc, sl|
        as = assign.call(sl)
        [acc[0] + as[0], acc[1] + as[1]]
    end
end

a0, a1, a2 = gets.strip.split(' ')
a0 = a0.to_i
a1 = a1.to_i
a2 = a2.to_i
b0, b1, b2 = gets.strip.split(' ')
b0 = b0.to_i
b1 = b1.to_i
b2 = b2.to_i
result = solve(a0, a1, a2, b0, b1, b2)
print result.join(" ")



