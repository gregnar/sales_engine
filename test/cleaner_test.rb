require_relative "helper_test"
require './lib/cleaner'
require 'bigdecimal'

class CleanerTest < Minitest::Test

  def test_it_downcases_a_string
    assert_equal "hello", Cleaner.clean("HEllO")
  end

  def test_it_downcases_another_string
    assert_equal "turing", Cleaner.clean("TURING")
  end

  def test_it_does_nothing_if_bigdecimal
    bd = BigDecimal.new(144509)
    assert_equal bd, Cleaner.clean(bd)
  end

  def test_it_does_nothing_if_integer
    assert_equal 99, Cleaner.clean(99)
  end

end
