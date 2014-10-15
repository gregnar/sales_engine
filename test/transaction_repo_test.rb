require_relative 'helper_test'
require './lib/transaction_repository'
require './lib/sales_engine'

class TransactionRepoTest < Minitest::Test
  attr_reader :transaction_repository, :engine

  def setup
    @engine = SalesEngine.new(File.expand_path("../data", __FILE__))
    @transaction_repository = @engine.transaction_repository
  end

  def test_repo_gets_populated
    transaction_repository.make_repo
    assert_instance_of Transaction, transaction_repository.repository[0], "not instance of Transaction"
    assert_instance_of Transaction, transaction_repository.repository[-1], "not instance of Transaction"
  end

  def test_it_has_a_repository
    transaction_repository.make_repo
    assert transaction_repository.repository
  end

  def test_it_exists
    assert @transaction_repository.repository
  end

  def test_it_has_a_sales_engine
    assert @transaction_repository.sales_engine
  end

  def test_it_returns_all_invoice_items
    assert @transaction_repository.repository
    transaction_repository.make_repo
    transaction = transaction_repository.repository.first
    assert_equal "4654405418249632", transaction.credit_card_number.to_s
    assert_equal "1", transaction.id.to_s
  end

end
