require_relative 'repository'
require_relative 'merchant'

class MerchantRepository < Repository
  attr_reader :repository, :sales_engine, :filepath

  def initialize(sales_engine, filepath)
    @sales_engine = sales_engine
    @repository = []
    @filepath = filepath
  end

  def inspect
    "#<#{self.class} #{@repository.size} rows>"
  end

  def make_repo
    populate_repository("#{filepath}/merchants.csv", Merchant)
  end

  def find_by_id(arg); find_by(:id, arg); end
  def find_by_name(arg); find_by(:name, arg); end
  def find_by_created_at(arg); find_by(:created_at, arg); end
  def find_by_updated_at(arg); find_by(:updated_at, arg); end

  def find_all_by_id(arg); find_all_by(:id, arg); end
  def find_all_by_name(arg); find_all_by(:name, arg); end
  def find_all_by_created_at(arg); find_all_by(:created_at, arg); end
  def find_all_by_updated_at(arg); find_all_by(:updated_at, arg); end

  def find_items_by_id(id)
    sales_engine.find_items_by_id(id)
  end

  def find_invoices_by_id(merchant_id)
    sales_engine.find_invoices_by_merchant_id(merchant_id)
  end

  def most_revenue(number_of_merchants)
    repository.each {|merchant| puts merchant.revenue }
    # sorted.pop(number_of_merchants)
  end

  def most_items(arg)
  end

  def revenue(date, arg)
    #revenue(date) returns the total revenue for that date across all merchants
    #find by invoice.merchant_id to return all seccessful transactions (via invoice_id) on a specific date
    #map merchant revenue by date, add the revenue to 0 to find
    #revenue = BigDecimal.new
  end

  def random
    repository.sample
  end
end
