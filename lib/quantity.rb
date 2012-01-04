# Copyright 2011 Fred George
# Distributed under the terms of the GNU Lesser General Public License v3

# Understands a particular measurement
class Quantity
  attr_reader :amount, :unit
  protected :amount, :unit

  def initialize(amount, unit)
    @amount, @unit = amount, unit
  end
  
  def ==(other)
    raise "Trying to compare a Quantity to a #{other.class}" unless other.kind_of?(Quantity)
    return true if self.object_id == other.object_id
    self.unit == other.unit && self.amount == other.amount
  end
  
end
