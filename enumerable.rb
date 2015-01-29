module Enumerable


  def my_map_test(proc = nil)
    unless proc
      self.my_each_with_index do |x, index|
        self[index] = yield(x)
      end
    else
      self.my_each_with_index do |x, index|
        self[index] = proc.call(x)
        self[index] = yield(self[index]) if block_given?
      end
    end
    self
  end

# assume enumerator returned if no block given
  def my_each
  	if (self.is_a? Array) && block_given?
  	  self.length.times { |i| yield(self[i]) }
  	end
  	self
  end

# if block not given then an enumerator is returned. What does that mean?
  def my_each_with_index 
  	if (self.is_a? Array) && block_given?
  	  self.length.times { |i| yield(self[i],i) }
  	end
  	self
  end

# if block not given then an enumerator is returned. What does that mean?
  def my_select
  	result = Array.new
  	if (self.is_a? Array) && block_given?
  	  self.length.times { |i| result << self[i] if yield(self[i]) }
  	end
  	result
  end

  def my_all?
  	if (self.is_a? Array) #&& block_given?
  	  result = true
  	  self.length.times do |i|
  	    compare_result = block_given? ? yield(self[i]) : self[i]
  	    if (!compare_result)
          result = false
          break
  	    end # if compare..
  	  end # times do..
  	end # if self..
  	result
  end # def

  def my_any?
  	if (self.is_a? Array) #&& block_given?
  	  result = false
  	  self.length.times do |i|
  	    compare_result = block_given? ? yield(self[i]) : self[i]
  	    if (compare_result)
          result = true
          break
  	    end # if compare..
  	  end # times do..
  	end # if self..
  	result
  end # def

  def my_none?
  	if (self.is_a? Array) #&& block_given?
  	  result = true
  	  self.length.times do |i|
  	    compare_result = block_given? ? yield(self[i]) : self[i]
  	    if (compare_result)
          result = false
          break 
  	    end # if compare..
  	  end # times do..
  	end # if self..
  	result
  end # def

  def my_count(*arg)
  	count = 0
  	if (self.is_a? Array) 
  	  if block_given?
        self.length.times { |i| count+=1 if yield(self[i]) }
  	  elsif arg.length == 0
        self.length.times { count+=1 }
      else
      	self.length.times { |i| count+=1 if self[i]==arg.first }
  	  end   
  	  count  
    end
  end	

# if block not given then an enumerator is returned. What does that mean?
  def my_map
  	result = Array.new
  	if (self.is_a? Array) && block_given?
  	  self.length.times { |i| result << yield(self[i]) }
  	end
  	result
  end

# did not implement other behavior with the symbols. not sure how at the moment
  def my_inject(*arg)
  	count = 0
  	if (self.is_a? Array) 
  	  if block_given?
  	  	if arg.length == 0
  	      result = self[0]
  	      start = 1
  	    else
  	      result = arg.first
  	      start = 0
  	    end # if arg
  	    start.upto(self.length-1) { |i| result = yield(result,self[i]) }
  	  end # if block
  	  result
  	end # if self
  end


  def my_map_proc(&handler)
  	result = Array.new
  	if (self.is_a? Array) #&& block_given?
  	  self.length.times { |i| result << handler.call(self[i]) }
  	end
  	result
  end

# This way won't work as it does not allow both block arg and actual block given to be passed to function
  def my_map_proc_block(&handler)
  # there seems to be an issue with block_given? and procs sent into argument list
  # block_given? returns true when a proc is sent as argument
    # executes proc if given
    # executes both block followed by proc if proc and block given
    # Does not execute block if proc not given
    puts "Block Given" if block_given? #also returns true when proc is sent
    result = Array.new
    if (self.is_a? Array) && block_given?
      self.length.times { |i| result << handler.call(self[i]) }
    end
    result
  end

  def my_map_new someProc=nil
    puts 'Before proc.call'
    result = Array.new
    if someProc && block_given?
     self.length.times { |i| result << someProc.call(yield(self[i])) }
    elsif someProc
      self.length.times { |i| result << someProc.call(self[i]) }
    else
      puts "nothing to do"
    end
    puts 'After proc.call'
    result
  end

end # module

  def multiply_els(arg)
    if arg.is_a? Array
  	  result = arg.my_inject { |prod,num| prod*num}
  	else
  	  puts "Not an array"
    end
    result
  end



p [1, 2, 3].my_each{ |x| puts x*x}
p [1, 2, 3].my_each_with_index{ |x,i| puts "Item #{i} is #{x}" }
p [1, 2, 3].my_select{ |x| x%2==1 }
puts "my_all results"
p [nil, nil, nil].my_all?
p [false, false, false].my_all?
p [false, false, true].my_all?
p [1, 2, 3].my_all?
p [1, 2, 3].my_all?{ |x| x<4 }
p [1, 2, 3].my_all?{ |x| x<3 }
puts "my_any results"
p [false, false, false].my_any?
p [false, false, true].my_any? 
p [1, 2, 3].my_any?{ |x| x/4==1 }
p [1, 2, 3].my_any?{ |x| x<3 }
puts "my_none results"
p [false, false, false].my_none? #all false -> true
p [nil, nil, nil].my_none?       #all false -> true
p [false, false, true].my_none?  #at least one true -> false
p [0, false, false].my_none?     #at least one true -> false
p [1, 2, 3].my_count
p [1, 2, 3, 1, 1].my_count(1)
p [1, 2, 3].my_count { |x| x>=2 }
puts "my_map results"
p [1, 2, 3].my_map { |x| x+2 }
puts "my_inject results"
p [1, 2, 3].my_inject { |prod,num| prod*num}
p [1, 2, 3].my_inject(2) { |prod,num| prod*num}
p [1, 2, 3, 4, 5].my_inject { |sum,num| sum+num}
p [1, 2, 3, 4, 5].my_inject(10) { |sum,num| sum+num}
p multiply_els([2, 4, 5])
puts "my_map_proc results" 
my_handler = Proc.new { |x| x+2 }
p [1, 2, 3].my_map_proc(&my_handler)
p [1,2,3].map(&my_handler)
puts "map_map_proc_block results"
p [1, 2, 3].my_map_proc_block(&my_handler) 
#p [1, 2, 3].my_map_proc_block()
p [1, 2, 3].my_map_new(my_handler) { |i| i-1 }


def my_map_new someProc=nil
  puts 'Before proc.call'
  if someProc && block_given?
    someProc.call
    yield
  elsif someProc
    someProc.call
  else
    puts "nothing to do"
  end
  puts 'After proc.call'
end

#my_proc = Proc.new { puts "Inside proc"}


#my_map_new (my_proc) { puts "Inside block"}
#my_map_new (my_proc)
#my_map_new 