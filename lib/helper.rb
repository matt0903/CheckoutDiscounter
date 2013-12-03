module Helper
  
  #Reduces the total by a set percentace and rounds to two decimal places to match currency
  def Helper.reduce_amount_by_set_percentage(amount, pc)
    value = amount
    value -= (amount.to_f / 100.to_f * pc.to_f)
    (value * 100).round.to_f / 100
  end
  
end
