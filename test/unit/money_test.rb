# Copyright 2012 Fred George
# Distributed under the terms of the GNU Lesser General Public License v3

require "test/unit"
require File.expand_path(File.join(File.dirname(__FILE__), '..', '..', 'lib', 'money_unit'))

# Confirms the operations for Money as a type of Quantity
class TestMoney < Test::Unit::TestCase
  
  def setup
    Valuation.reset
    Valuation.new(MoneyUnit::USD, MoneyUnit::GBP, 1.55)
  end

  def test_equality
    assert_equal(3.usd, 3.usd)
    assert_equal(3.00.usd, 3.usd)
    assert_equal(3.00.usd, 3.001.usd)   # Track to nearest penny for USD
    assert_equal(3.1.jpy, 3.2.jpy)      # Track whole Japanese Yen only
    assert_not_equal(3.10.usd, 3.20.usd)
  end
  
  def test_quantity_creation_from_unit
    assert_equal(3.15.usd, MoneyUnit::USD.amount(3.15))
    assert_equal(3.15.usd, MoneyUnit.for('USD').amount(3.15))
  end
  
  def test_incorrect_unit_caught
    assert_raise(RuntimeError) { MoneyUnit.for('MISSING') }
  end
  
  def test_sorting
    assert_equal([1.usd, 2.usd, 3.usd], [3.usd, 1.usd, 2.usd].sort)
  end
  
  def test_sorting_fails_with_mixed_units
    assert_raise(ArgumentError) { [1.usd, 3.usd, 2.jpy].sort }
  end
  
  def test_addition
    assert_equal(7.usd, 3.usd + 4.usd)
    assert_equal(7.usd, -4.usd + 11.usd)
  end
  
  def test_subtraction
    assert_equal(7.usd, 11.usd - 4.usd)
  end
  
  def test_arithmetic_fails_with_mixed_units
    assert_raise(ArgumentError) { 1.usd + 2.jpy }
    assert_raise(ArgumentError) { 1.usd - 2.jpy }
  end
  
  def test_scaling
    assert_equal(6.usd, 8.usd * 75.percent)
    assert_equal(10.usd, 8.usd + 25.percent)
    assert_equal(6.usd, 8.usd - 25.percent)
  end
  
  def test_autoboxing_numerics
    assert_equal(6.usd, 8.usd * 0.75)
    assert_equal(10.usd, 8.usd + 0.25)
    assert_equal(6.usd, 8.usd - 0.25)
  end
  
  def test_mixed_currency_equality
    assert_equal(3.10.usd, 2.gbp)
  end

end