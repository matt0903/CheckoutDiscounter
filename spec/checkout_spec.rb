require "#{File.dirname(__FILE__)}/../lib/checkout"
require "#{File.dirname(__FILE__)}/../lib/item"
require "#{File.dirname(__FILE__)}/../lib/helper"

describe Checkout, "#total" do

  before(:each) do
    #Sets up the products to be used while running the tests
    @items = []
    @items.push(Item.new(001, "Travel Card Holder"      , 9.25))
    @items.push(Item.new(002, "Personalised cufflinks"  , 45.00))
    @items.push(Item.new(003, "Kids T-shirt"            , 19.95))

    @rules = []
    #Sets the rule that when more than £60 is spent 10% is deducted from the total
    @rules << Rule.new(:given_type => :discount, :when_amount => 60, :deduct => 10)
    
    #Sets the rule that if two or more Travel Card Holders are purchaced the cost is reduced to £8.50 each 
    @rules << Rule.new(:given_type => :count, :when_amount => 2, :from_product => 001, :deduct => 8.50)
  end

  it "Checks that the 10% off works correctly" do
    co = Checkout.new(@rules)
    item = Item.new(111, "test", 72)
    co.scan(item)
    co.total.should == Helper.reduce_amount_by_set_percentage(72, 10)
  end

  it "Checks that the price of the travel card holder is reduced to 8.50 when two or more are purchased" do
    co = Checkout.new(@rules)
    co.scan(@items[0]).scan(@items[0])
    co.total.should == 2 * 8.5
  end

  #Items in basket: 001,002,003
  it "Checks that test basket one gives 66.78" do
    co = Checkout.new(@rules)
    co.scan(@items[0]).scan(@items[1]).scan(@items[2])
    co.total.should == 66.78
  end

  #Items in basket: 001,003,001
  it "Checks that test basket two gives 36.95" do
    co = Checkout.new(@rules)
    co.scan(@items[0]).scan(@items[2]).scan(@items[0])
    co.total.should == 36.95
  end

  #Items in basket: 001,002,001,003
  it "Checks that test basket two gives 73.76" do
    co = Checkout.new(@rules)
    co.scan(@items[0]).scan(@items[1]).scan(@items[0]).scan(@items[2])
    co.total.should == 73.76
  end

end
