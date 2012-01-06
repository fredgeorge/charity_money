# Copyright 2012 Fred George
# Distributed under the terms of the GNU Lesser General Public License v3

# Understands a quantitative relationship between two Units
class Valuation
  @@all = {}
  
  def initialize(source_unit, target_unit, conversion_ratio)
    @@all[[source_unit, target_unit]] = conversion_ratio
    @@all[[target_unit, source_unit]] = 1.0 / conversion_ratio
  end
  
  def self.ratio(source_unit, target_unit)
    return 1.0 if source_unit == target_unit
    @@all.fetch([source_unit, target_unit]) { raise ArgumentError.new("Cannot convert between the specified Units") }
  end
  
  def self.reset
    @@all = {}
  end
  
end