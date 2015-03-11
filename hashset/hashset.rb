class Hashset
  def initialize
    @buckets = Array.new(8) { [] }
    @num_elem = 0
  end

  def include?(obj)
    bucket =
      obj.class == Fixnum ? @buckets[obj % @buckets.length] :
      @buckets[obj.hash % @buckets.length]

    bucket.include?(obj)
  end

  def insert(obj)
    return false if self.include?(obj)
    bucket =
      obj.class == Fixnum ? @buckets[obj % @buckets.length] :
        @buckets[obj.hash % @buckets.length]

    bucket << obj
    @num_elem += 1
    self.resize! if @num_elem == @buckets.length
  end

  def delete(obj)
    return false unless self.include?(obj)
    bucket =
      obj.class == Fixnum ? @buckets[obj % @buckets.length] :
        @buckets[obj.hash % @buckets.length]

    bucket.delete(obj)
    @num_elem -= 1
  end

  protected
  def resize!
    old_buckets = @buckets
    @buckets = Array.new(old_buckets.length * 2) { [] }

    old_buckets.each do |arr|
      arr.each { |el| self.insert(el) }
    end
  end
end
