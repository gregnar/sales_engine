class Customer
  attr_reader :id,
              :first_name,
              :last_name,
              :created_at,
              :updated_at,
              :repository

  def initialize(data, repository)
    @id           = data[:id]
    @first_name   = data[:first_name]
    @last_name    = data[:last_name]
    @created_at   = data[:created_at]
    @updated_at   = data[:updated_at]
    @repository   = repository
  end

  def invoices
    repository.find_invoices_by_id(self.id)
  end

  def transactions
    invoices.flat_map(&:transactions)
  end

  def successful_transactions
    transactions.select(&:success?)
  end

  def pending_transactions_with_merchant?(merchant_obj)
    invoices_with_merchant = invoices.find_all {|i| i.merchant == merchant_obj }
    invoices_with_merchant.any? { |i| i.transactions.none?(&:success?) }
  end

  def successful_transactions_with_merchant(merchant_obj)
    successful_transactions.select {|trans| trans.merchant == merchant_obj }
  end

  def favorite_merchant
    #where customer has conducted the most successful transactions
  end

end
