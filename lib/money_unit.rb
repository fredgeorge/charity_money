# Copyright 2012 Fred George
# Distributed under the terms of the GNU Lesser General Public License v3

# Understands a metric
require File.expand_path(File.join(File.dirname(__FILE__), 'quantity'))

class MoneyUnit
  attr_reader :label, :subunits
  private :label, :subunits
  
  @@all = {}

  def initialize(label, minimum_subunits = 1)
    @label, @subunits = label, minimum_subunits
    create_unit_constant
    create_unit_method
  end
  
  def amount(amount)
    Quantity.new((amount * @subunits).round, self)
  end
  
  def self.for(label)
    @@all.fetch(label.upcase) { raise "No unit found for '#{label}'" }
  end
  
  private
  
    def create_unit_constant
      @@all[@label.upcase] = self
      self.class.const_set(@label.upcase.to_sym, self)
    end
  
    def create_unit_method
      unit = self
      Numeric.class_eval do
        define_method unit.send(:label).downcase.to_sym do
          Quantity.new((self * unit.send(:subunits)).round, unit)
        end
      end
    end
  
  MoneyUnit.new 'USD', 100
  MoneyUnit.new 'GBP', 100
  MoneyUnit.new 'JPY'
  
end