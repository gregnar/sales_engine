require_relative 'helper_test'
require './lib/item_repository'
require './lib/csv_parser'
require './lib/sales_engine'

class ItemRepositoryTest < Minitest::Test
  attr_reader :item_repository, :engine

  def setup
    @engine = SalesEngine.new(File.expand_path("../data", __FILE__))
    @engine.startup
    @item_repository = @engine.item_repository
  end

  def test_it_has_a_repository
    assert item_repository.repository
  end

  def test_it_exists
    assert item_repository
  end

  def test_it_has_a_sales_engine
    assert engine.item_repository
  end

  def test_random
    item_one = engine.item_repository.random
    item_two = engine.item_repository.random
    10.times do
      break if item_one.id != item_two.id
      item_two = engine.item_repository.random
    end
    refute item_one == item_two
  end
end
