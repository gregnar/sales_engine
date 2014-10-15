require_relative 'helper_test'
require './lib/item'
require './lib/sales_engine'

class ItemTest < Minitest::Test

  def setup
    @engine = SalesEngine.new(File.expand_path("../data", __FILE__))
    @engine.startup
    @item = @engine.item_repository.find_by_id(1)
  end

  def test_find_by_unit_price
    item = @engine.item_repository.find_by_unit_price(BigDecimal.new("751.07"))
    item.name
    assert_equal "Item Qui Esse", item.name
  end

  def test_revenue
    assert_equal 681.75, @item.revenue.to_f
  end

  def test_number_sold
    assert_equal 5, @item.number_sold
  end

  def test_best_day
    assert_instance_of Date, @item.best_day
  end


end
