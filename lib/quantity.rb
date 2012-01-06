# Copyright 2012 Fred George
# Distributed under the terms of the GNU Lesser General Public License v3

require File.expand_path(File.join(File.dirname(__FILE__), 'base', 'numeric'))

# Understands a particular measurement
class Quantity
  include Comparable
  
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
  
  def <=>(other)
    raise ArgumentError.new('Units cannot be compared') unless self.unit == other.unit
    self.amount <=> other.amount
  end
  
  def +(other)
    return self + Unit::SCALE.amount(other) if other.is_a?(Numeric)
    return self * Unit::SCALE.amount(1 + other.amount) if other.unit == Unit::SCALE
    raise ArgumentError.new('Different units cannot be added or subtracted') unless self.unit == other.unit
    self.class.new(self.amount + other.amount, self.unit)
  end
  
  def -@
    self.class.new(-@amount, @unit)
  end
  
  def -(other)
    self + (-other)
  end
  
  def *(other)
    return self * Unit::SCALE.amount(other) if other.is_a?(Numeric)
    self.class.new(self.amount * other.amount, self.unit)
  end
  
end
