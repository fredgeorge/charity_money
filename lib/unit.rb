# Copyright 2012 Fred George
# Distributed under the terms of the GNU Lesser General Public License v3

# Understands a metric
class Unit
  
  def amount(amount)
    Quantity.new(amount, self)
  end
  
  SCALE = Unit.new
    
end