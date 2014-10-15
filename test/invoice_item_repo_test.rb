require_relative 'helper_test'
require './lib/invoice_item_repository'
require './lib/sales_engine'

class InvoiceItemRepoTest < Minitest::Test

  attr_reader :invoice_item_repository, :engine

  def setup
    @engine = SalesEngine.new
    @invoice_item_repository = InvoiceItemRepository.new(SalesEngine.new, "data")
  end

  def test_repo_gets_populated
    invoice_item_repository.make_repo
    assert_instance_of InvoiceItem, invoice_item_repository.repository[0], "not instance of InvoiceItem"
    assert_instance_of InvoiceItem, invoice_item_repository.repository[-1], "not instance of InvoiceItem"
  end

  def test_it_has_a_repository
    invoice_item_repository.make_repo
    assert invoice_item_repository.repository
  end

  def test_it_exists
    assert invoice_item_repository
  end

  def test_it_has_a_sales_engine
    assert engine.invoice_item_repository
  end

  def test_it_returns_all_invoice_items
    assert invoice_item_repository.repository
    invoice_item_repository.make_repo
    ii = invoice_item_repository.repository.first
    assert_equal "5", ii.quantity.to_s
    assert_equal "1", ii.id.to_s
  end

end
