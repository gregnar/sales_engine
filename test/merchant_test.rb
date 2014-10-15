require_relative "helper_test"
require './lib/merchant'
require './lib/sales_engine'

class MerchantTest < Minitest::Test

  def setup
    @engine = SalesEngine.new(File.expand_path("../data", __FILE__))
    @engine.startup
    @merchant = @engine.merchant_repository.find_by_id(26)
  end

  def test_customers
    assert_equal 1, @merchant.customers.first.id
  end

  def test_revenue_with_date
    date = Date.parse("2012-03-25 14:54:09 UTC")
    assert_equal 21067.77, @merchant.revenue(date).to_f
  end

  def test_items_sold
    assert_equal 47, @merchant.items_sold
  end

  def test_favorite_customer
    assert_instance_of Customer, @merchant.favorite_customer
  end

  def test_customers_with_pending_invoices
    merchant = @engine.merchant_repository.find_by_id(25)
    pending  = merchant.customers_with_pending_invoices
    assert_instance_of Array, pending
    assert_equal 1, pending.count
  end

end
