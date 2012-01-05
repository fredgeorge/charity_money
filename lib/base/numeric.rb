# Copyright 2012 Fred George
# Distributed under the terms of the GNU Lesser General Public License v3

class Numeric
  
  def percent
    Unit::SCALE.amount(self / 100.0)
  end
  
end