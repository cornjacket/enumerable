require "spec_helper"

describe "my_each"  do

  a = [1, 2, 3]

  it "returns itself" do
  	expect(a.my_each{ |i| i }).to eq a
  end

  it "returns itself" do
    expect([].my_each{ |i| i }).to eq []
  end  

  it "sequentially processes each element in an array if given a block" do
    result = []    
    a.my_each{ |i| result << i*2 }
    expect(result).to eq [2, 4, 6]
  end

end


describe "my_select"  do

  a = [1, 2, 3]

  it "returns an array of odd numbers if given a block wth the mod operator" do
    expect(a.my_select{ |i| i%2==1 }).to eq [1, 3]
  end

  it "returns an empty array if there are no matches to block" do
    expect(a.my_select{ |i| i>4 }).to eq []
  end

end


describe "my_count"  do

  a = [1, 2, 3]

  it "returns the number of occurences where the input's elements are > 1" do
    expect(a.my_count{ |i| i>1 }).to eq 2
  end

  it "returns 0 where the input's elements cause the expression to always be false" do
    expect(a.my_count{ |i| i>5 }).to eq 0
  end

end


describe "my_none?"  do

  it "returns true when all array items are false" do
    expect([false, false, false].my_none?).to eq true
  end

  it "returns true when all array items are nil" do
    expect([nil, nil, nil].my_none?).to eq true
  end

  it "returns false when at least one array item is true" do
    expect([false, false, true].my_none?).to eq false
  end

  it "returns false when at least one array item is truthy (ie. 0)" do
    expect([0, false, false].my_none?).to eq false
  end

end


describe "my_all?"  do

  a = [1, 2, 3]

  it "returns false when all array items are false if not given a block" do
    expect([false, false, false].my_all?).to eq false
  end

  it "returns false when all array items are nil if not not given a block" do
    expect([nil, nil, nil].my_all?).to eq false
  end  

  it "returns false when at least one array item is false if not given a block" do
    expect([false, false, true].my_all?).to eq false
  end

  it "returns true when all array items are truthy if not given a block" do
    expect(a.my_all?).to eq true
  end 

  it "returns true when all array items satisfy the condition given by the provided block" do
    expect(a.my_all?{ |x| x<4 }).to eq true
  end

  it "returns false when all array items do not satisfy the condition given by the provided block" do
    expect(a.my_all?{ |x| x<3 }).to eq false
  end   

end

describe "my_any?"  do

  a = [1, 2, 3]

  it "returns false when all array items are false" do
    expect([false, false, false].my_any?).to eq false
  end

  it "returns false when all array items are nil" do
    expect([nil, nil, nil].my_any?).to eq false
  end

  it "returns true when at least one array item is true" do
    expect([false, false, true].my_any?).to eq true
  end

  it "returns true when at least one array item is truthy (ie. 0)" do
    expect([0, false, false].my_any?).to eq true
  end

  it "returns false when passing a block which evaluates all in array to false" do
    expect(a.my_any?{ |x| x/4==1 }).to eq false
  end

  it "returns true when passing a block which evaluates at least one array item to true" do
    expect(a.my_any?{ |x| x<3 }).to eq true
  end

end
