class Item

  #Allows the product_code, name and price to be written to
  attr_accessor :code, :name, :price

  #Initializes the code, name and price for items
  def initialize(code, name, price)
    @code, @name, @price = code, name, price
  end

  #Converts to a string by calling the to_s function
  def to_s
    "Item->Product code:#{@code}, Name:#{@name}, Price:#{@price}"
  end

end
