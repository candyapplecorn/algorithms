# Enter your code here. Read input from STDIN. Print output to STDOUT

class SeqList
    def initialize(n)
        @n = n
        @sequences = Array.new(n){ [] }
        @lastAnswer = 0
    end

    def q1(x, y)
        @sequences[(x ^ @lastAnswer) % @n] << y
    end
    
    def q2(x, y)
        @lastAnswer = @sequences[(x ^ @lastAnswer) % @n][y % @sequences[(x ^ @lastAnswer) % @n].length]
        p @lastAnswer
    end
end

dimensions = gets.chomp.split.map &:to_i
seq = SeqList.new(dimensions.first)

while gets
    query = $_.split.map &:to_i
    type = query.shift
    
    if type == 1
        seq.q1 query.first, query.last
    else
        seq.q2 query.first, query.last
    end
end
