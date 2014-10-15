require_relative 'helper_test'
require './lib/invoice_item_repository'
require './lib/sales_engine'

class InvoiceItemRepoTest < Minitest::Test

  attr_reader :invoice_item_repository, :engine

  def setup
    @engine = SalesEngine.new(File.expand_path("../data", __FILE__))
    @engine.startup
    @invoice_item_repository = @engine.invoice_item_repository
  end

  def test_it_has_a_repository
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
    assert_equal 5, ii.quantity
    assert_equal 1, ii.id
  end

  def test_random
    invoice_item_one = engine.invoice_item_repository.random
    invoice_item_two = engine.invoice_item_repository.random
    10.times do
      break if invoice_item_one.id != invoice_item_two.id
      invoice_item_two = engine.invoice_item_repository.random
    end
    refute invoice_item_one == invoice_item_two
  end

end
