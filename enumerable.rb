module Enumerable
    def my_each(array)
        for e in array
            yield(e)
        end
    end
    def my_each_with_index(array)
        for i in (0...array.length)
            yield array[i], i
        end
    end
    def my_select(array)
        new_array = []
        my_each(array){ |n| new_array.push(n) if yield(n) }
        new_array
    end
    def my_all?(array)
        if block_given?
            my_each(array){ |n| return false if !yield(n) }
            
        else
            my_each(array){ |n| return false if !n }
        end
        return true
    end
end

class Test
    include Enumerable
end
test = Test.new

puts test.my_all?([2,4]){|n|
    n % 2 == 0
}