# Copyright 2012 Fred George
# Distributed under the terms of the GNU Lesser General Public License v3

# Confirms the operations for Money as a type of Quantity
require "test/unit"

require File.expand_path(File.join(File.dirname(__FILE__), '..', '..', 'lib', 'unit'))

class TestMoney < Test::Unit::TestCase

  def test_equality
    assert_equal(3.usd, 3.usd)
    assert_equal(3.00.usd, 3.usd)
    assert_equal(3.00.usd, 3.001.usd)   # Track to nearest penny for USD
    assert_equal(3.1.jpy, 3.2.jpy)      # Track whole Japanese Yen only
    assert_not_equal(3.10.usd, 3.20.usd)
  end
  
  def test_quantity_creation_from_unit
    assert_equal(3.15.usd, Unit::USD.amount(3.15))
    assert_equal(3.15.usd, Unit.for('USD').amount(3.15))
  end
  
  def test_incorrect_unit_caught
    assert_raise(RuntimeError) { Unit.for('MISSING') }
  end
  
  def test_sorting
    assert_equal([1.usd, 2.usd, 3.usd], [3.usd, 1.usd, 2.usd].sort)
  end
  
  def test_sorting_fails_with_mixed_units
    assert_raise(ArgumentError) { [1.usd, 3.usd, 2.jpy].sort }
  end

end