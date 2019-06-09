module Enumerable
  # module implements some enumerable methods of ruby
  # by adding my_ to the default method names
  def my_each
    if self.kind_of?Array
      for e in self
        yield(e)
      end
    end
    if self.kind_of?Hash
      for k, v in self
        yield(k, v)
      end
    end
  end

  def my_each_with_index
    for i in (0...self.length)
      yield self[i], i
    end
  end

  def my_select
    new_array = []
    self.my_each{ |n| new_array.push(n) if yield(n) }
    new_array
  end

  def my_all?
    if block_given?
      self.my_each{ |n| return false if !yield(n) }
    else
      self.my_each{ |n| return false if !n }
    end
    return true
  end

  def my_any?
    if block_given?
      self.my_each{ |n| return true if yield(n) }
    else
      self.my_each{ |n| return true if n }
    end
    return false
  end

  def my_none?
    if block_given?
      self.my_each{ |n| return false if yield(n) }
    else
      self.my_each{ |n| return false if n }
    end
    return true
  end

  def my_count(obj=nil)
    count = 0
    if block_given?
        self.my_each{ |n| count += 1 if yield(n) }
    else
        if obj.nil?
            self.my_each{ |n| count += 1 }
        else
            self.my_each{ |n| count += 1 if obj == n }
        end
    end
    return count
  end
  def my_map(&proc)
    if self.kind_of?Array
      new_array = []
      self.my_each{ |n| new_array.push(proc.call(n)) }
      return new_array
    end
    if self.kind_of?Hash
      new_hash = {}
      self.my_each{ |k, v| new_hash.update(proc.call(k,v))}
      return new_hash
    end
  end

  def my_inject(accumulator=0)
    if accumulator == 0
      accumulator = self.first
      self[1,self.length-1].my_each{ |n| accumulator = yield(accumulator, n) }
    else
      self.my_each{ |n| accumulator = yield(accumulator, n) } 
    end
      accumulator
  end
end

def multiply_els(array)
  array.my_inject{ |a, b| a*b }
end

array = [3,1,5,6,3,6]

#testing each method in enumerable module on array variable
array.my_each{ |n| print n }                                    # 315636
puts ""
array.my_each_with_index{ |n, i| puts "#{n} #{i}" }             # (3 0) (1 1) (5 2) (6 3) (3 4) (6 5)
print array.my_select{ |n| n%2 == 0 }                           # [6, 6]
puts ""
print array.my_all?{ |n| n < 10 }                               # true
puts ""
print array.my_any?{ |n| n < 10 }                               # true
puts ""
print array.my_none?{ |n| n > 10 }                              # true
puts ""
print array.my_count(6)                                         # 2
puts ""
print array.my_count{ |n| n >= 3 }                              # 5
puts ""
print array.my_count                                            # 6
puts ""
proc = Proc.new{ |n| n*2 }      
print [3,5,4].my_map(&proc)                                     # [6, 10, 8]
puts ""
print multiply_els([2,4,5])                                     # 40
puts ""