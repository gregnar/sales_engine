class Merchant
  attr_reader :id,
              :name,
              :created_at,
              :updated_at,
              :repository

  def initialize(data, repository)
    @id          = data[:id]
    @name        = data[:name]
    @created_at  = data[:created_at]
    @updated_at  = data[:updated_at]
    @repository  = repository
  end

  def items
    repository.find_items_by_id(self.id)
  end

  def invoices
    repository.find_invoices_by_id(self.id)
  end

  def revenue
    #all revenues must be BigDecimal
  end

  def revenue(date_arg)
  end

  def favorite_customer
    #customer who has conducted the most successful transactions
  end

  def customers_with_pending_invoices
  end

end
