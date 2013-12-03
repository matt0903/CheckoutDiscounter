require "#{File.dirname(__FILE__)}/../lib/rule"

class Checkout

  #Initializes the checkout discount rules
  def initialize(rules)
    
    @items = []
    @items_hash = {}
    Rule.add(rules)
    
  end

  #Defines the scan method
  def scan(item)
    
    @items << item if item.class == Item
    @items_hash[item.code] ||= 0;
    @items_hash[item.code] += 1;
    self
    
  end

  #Defines the checkout total after all deductions from discounts
  def total
    
    sum = 0
    @items = Rule.match(@items_hash, @items)
    
    @items.each do |item|
      sum += item.price
    end

    sum = Rule.discount(sum)
    
  end

  #Converts the total price to a string
  def to_s
    
    s = "Basket has #{@items.count} items :"
    if @items.count
      @items.each { |item| s += "#{item.product}, " }
      s += "\nTotal price :" + self.total.to_s()
    end
    
  end

end
