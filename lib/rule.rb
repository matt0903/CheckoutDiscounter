require "#{File.dirname(__FILE__)}/helper"

class Rule

  #Allows the type, ammout, value and code of rules to be read but not changed
  attr_reader :type, :amount, :value, :code

  #Imitates the databse
  @@rules = []

  #Initializes the rule type, ammount, value and code fields
  def initialize(params={})
    @type = params[:given_type]
    @amount = params[:when_amount]
    @value = params[:deduct]
    @code = params[:from_product]
  end

  #Converts to string by calling the to_s method
  def to_s
    "Rules->type:#{type}, amount:#{amount}, value:#{value}, code:#{code}"
  end

  def self.add(item)
    @@rules << item if item.class == Rule
    @@rules += item if item.class == Array
  end

  #Defines the percentage discount method
  def self.discount(total)
    rule = @@rules.find { |rule| rule.type == :discount }
    total = Helper.reduce_amount_by_set_percentage(total, rule.value) if total > rule.amount
    total
  end

  #Finds discount rules matched to items and if one is found it applies it.
  def self.match(ih, items)
    result = items.find_all do |item|
      rules = @@rules.find_all { |rule| rule.code == item.code }
      rules.each do |apply_rule|
        item.price = apply_rule.value if ih[apply_rule.code] >= apply_rule.amount
      end
    end
    items
  end

end
