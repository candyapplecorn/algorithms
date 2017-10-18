class Fixnum
  # Fixnum#hash already implemented for you
end

class Array
  def hash
    (0..length).to_a.inject(0) { |a, i|
      a + self[i].hash * i.hash }
  end
end

class String
  def hash
    chars.map(&:ord).hash
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    keys.sort.hash
  end
end
