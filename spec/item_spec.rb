require "#{File.dirname(__FILE__)}/../lib/item"

describe Item  do

  it "Tests wether the product code can be updated successfully" do
    item = Item.new(0,0,0)
    item.product_code = 10
    item.product_code.should == 10
  end
  
end