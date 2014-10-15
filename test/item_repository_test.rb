require_relative 'helper_test'
require './lib/item_repository'
require './lib/csv_parser'
require './lib/sales_engine'

class ItemRepositoryTest < Minitest::Test
  attr_reader :item_repository, :engine

  def setup
    @engine = SalesEngine.new(File.expand_path("../data", __FILE__))
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

end
