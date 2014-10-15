require_relative 'helper_test'
require './lib/customer_repository'
require './lib/sales_engine'


class CustomerRepoTest < Minitest::Test
  attr_reader :engine, :customer_repository

  def setup
    @engine = SalesEngine.new(File.expand_path("../data", __FILE__))
    @engine.startup
    @customer_repository = @engine.customer_repository
  end

  def test_find_by_first_name
    assert_equal customer_repository.repository[1], customer_repository.find_by_first_name("cecelia")
  end

  def test_find_by_created_at
    assert_equal customer_repository.repository[1], customer_repository.find_by_created_at("2012-03-27 14:54:10 UTC")
  end

  def test_random
    customer_one = engine.customer_repository.random
    customer_two = engine.customer_repository.random
    10.times do
      break if customer_one.id != customer_two.id
      customer_two = engine.customer_repository.random
    end
    refute customer_one == customer_two
  end

end
