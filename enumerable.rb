# frozen_string_literal: true

module Enumerable
  def my_each
    if is_a? Array
      each do |e|
        yield(e)
      end
    end
    if is_a? Hash
      each do |k, v|
        yield(k, v)
      end
    end
  end

  def my_each_with_index
    (0...length).each do |i|
      yield self[i], i
    end
  end

  def my_select
    new_array = []
    my_each { |n| new_array.push(n) if yield(n) }
    new_array
  end

  def my_all?
    if block_given?
      my_each { |n| return false unless yield(n) }
    else
      my_each { |n| return false unless n }
    end
    true
  end

  def my_any?
    if block_given?
      my_each { |n| return true if yield(n) }
    else
      my_each { |n| return true if n }
    end
    false
  end

  def my_none?
    if block_given?
      my_each { |n| return false if yield(n) }
    else
      my_each { |n| return false if n }
    end
    true
  end

  def my_count(obj = nil)
    count = 0
    if block_given?
      my_each { |n| count += 1 if yield(n) }
    else
      if obj.nil?
        my_each { |_n| count += 1 }
      else
        my_each { |n| count += 1 if obj == n }
      end
    end
    count
  end

  def my_map(&proc)
    if is_a? Array
      new_array = []
      my_each { |n| new_array.push(proc.call(n)) }
      return new_array
    end
    if is_a? Hash
      new_hash = {}
      my_each { |k, v| new_hash.update(proc.call(k, v)) }
      return new_hash
    end
  end

  def my_inject(accumulator = 0)
    if accumulator == 0
      accumulator = first
      self[1, length - 1].my_each { |n| accumulator = yield(accumulator, n) }
    else
      my_each { |n| accumulator = yield(accumulator, n) }
    end
    accumulator
  end
end

def multiply_els(array)
  array.my_inject { |a, b| a * b }
end

array = [3, 1, 5, 6, 3, 6]

# testing each method in enumerable module on array variable
array.my_each { |n| print n } # 315636
puts ''
array.my_each_with_index { |n, i| puts "#{n} #{i}" }
print array.my_select(&:even?)
puts ''
print array.my_all? { |n| n < 10 }
puts ''
print array.my_any? { |n| n < 10 }
puts ''
print array.my_none? { |n| n > 10 }
puts ''
print array.my_count(6)
puts ''
print array.my_count { |n| n >= 3 }
puts ''
print array.my_count
puts ''
proc = proc { |n| n * 2 }
print [3, 5, 4].my_map(&proc)
puts ''
print multiply_els([2, 4, 5])
puts ''
