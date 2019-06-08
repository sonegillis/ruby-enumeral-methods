module Enumerable
    def my_each
        for e in self
            yield(e)
        end
    end
    def my_each_with_index
        for i in (0...array.length)
            yield array[i], i
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
end

puts [3,4,5,2].my_count(5) do
end