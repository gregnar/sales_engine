require_relative 'helper_test'
require './lib/merchant_repository'
require './lib/sales_engine'


class MerchantRepositoryTest < Minitest::Test

  attr_reader :merchant_repository, :engine

  def setup
    @engine = SalesEngine.new
    @merchant_repository = MerchantRepository.new(SalesEngine.new, "data")
  end

  def test_repo_gets_populated
    merchant_repository.make_repo
    assert_instance_of Merchant, merchant_repository.repository[0], "not instance of Merchant"
    assert_instance_of Merchant, merchant_repository.repository[-1], "not instance of Merchant"
  end

  def test_it_has_a_repository
    merchant_repository.make_repo
    assert merchant_repository.repository
  end

  def test_it_exists
    assert merchant_repository
  end

  def test_it_has_a_sales_engine
    assert engine.merchant_repository
  end

  def test_it_returns_all_merchants
    assert merchant_repository.repository
    merchant_repository.make_repo
    merchant = merchant_repository.repository.last
    assert_equal "Wisozk, Hoeger and Bosco", merchant.name.to_s
    assert_equal "100", merchant.id.to_s
  end
end
