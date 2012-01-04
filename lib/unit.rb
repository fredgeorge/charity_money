# Copyright 2011 Fred George
# Distributed under the terms of the GNU Lesser General Public License v3

# Understands a metric
require File.expand_path(File.join(File.dirname(__FILE__), 'quantity'))

class Unit
  attr_reader :label, :subunits
  private :label, :subunits

  def initialize(label, minimum_subunits = 1)
    @label, @subunits = label, minimum_subunits
    create_unit_method
  end
  
  private
  
    def create_unit_method
      unit = self
      Numeric.class_eval do
        define_method unit.send(:label).downcase.to_sym do
          Quantity.new((self * unit.send(:subunits)).round, unit)
        end
      end
    end
  
  Unit.new 'USD', 100
  Unit.new 'GBP', 100
  Unit.new 'JPY'
  
end