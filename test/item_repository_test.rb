require_relative 'helper_test'
require './lib/item_repository'
require './lib/csv_parser'
require './lib/sales_engine'

class ItemRepositoryTest < Minitest::Test
  attr_reader :item_repository, :engine

  def setup
    @engine = SalesEngine.new
    @item_repository = ItemRepository.new(SalesEngine.new, "data")
  end

  def test_repo_gets_populated
    item_repository = ItemRepository.new(SalesEngine.new, "data")
    item_repository.make_repo
    assert_instance_of Item, item_repository.repository[0], "not instance of Item"
    assert_instance_of Item, item_repository.repository[-1], "not instance of Item"
  end

  def test_it_has_a_repository
    item_repository.make_repo
    assert item_repository.repository
  end

  def test_it_exists
    assert item_repository
  end

  def test_it_has_a_sales_engine
    assert engine.item_repository
  end

  def test_it_returns_all_invoice_items
    assert item_repository.repository
    item_repository.make_repo
    item = item_repository.repository.last
    assert_equal "100", item.merchant_id.to_s
    assert_equal "2483", item.id.to_s
  end
end
