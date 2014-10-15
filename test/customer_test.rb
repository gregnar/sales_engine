require_relative "helper_test"
require "./lib/customer"
require "./lib/sales_engine"

class CustomerTest < Minitest::Test

  def setup
    @engine             = SalesEngine.new(File.expand_path("../data", __FILE__))
    @engine.startup
  end

  def test_transactions
    customer = @engine.customer_repository.find_by_id(1)
    assert_equal 1, customer.transactions.first.invoice.customer.id
  end

  def test_successful_transactions_count_is_less_than_transactions_count
    customer = @engine.customer_repository.find_by_id(3)
    transactions = customer.transactions
    successful_transactions = customer.successful_transactions
    assert successful_transactions.count < transactions.count
  end

  def test_successful_transactions_equals_transactions_if_no_failed_transactions
    customer = @engine.customer_repository.find_by_id(1)
    transactions = customer.transactions
    successful_transactions = customer.successful_transactions
    assert successful_transactions.count == transactions.count
  end

  def test_pending_transactions_with_merchant_is_false
    merchant = @engine.merchant_repository.find_by_id(1)
    customer = @engine.customer_repository.find_by_id(1)
    refute customer.pending_transactions_with_merchant?(merchant)
  end

  def test_pending_transactions_with_merchant_is_true
    merchant = @engine.merchant_repository.find_by_id(28)
    customer = @engine.customer_repository.find_by_id(8)
    assert customer.pending_transactions_with_merchant?(merchant)
  end

  def test_successful_transactions_with_merchant
    merchant = @engine.merchant_repository.find_by_id(26)
    customer = @engine.customer_repository.find_by_id(1)
    assert_equal 1, customer.successful_transactions_with_merchant(merchant).count
  end

  def test_merchants
    customer = @engine.customer_repository.find_by_id(1)
    assert 8, customer.merchants.count
    assert 26, customer.merchants.first.id
  end

  def test_favorite_merchant
    merchant = @engine.merchant_repository.find_by_id(26)
    customer = @engine.customer_repository.find_by_id(1)
    assert_equal 26, customer.favorite_merchant.id
  end
end
