# Copyright 2011 Fred George
# Distributed under the terms of the GNU Lesser General Public License v3

# Confirms the operations for Money as a type of Quantity
require "test/unit"

require File.expand_path(File.join(File.dirname(__FILE__), '..', '..', 'lib', 'unit'))

class TestMoney < Test::Unit::TestCase

  def test_equality
    assert_equal(3.usd, 3.usd)
    assert_equal(3.00.usd, 3.usd)
    assert_equal(3.00.usd, 3.001.usd)
  end
  
end