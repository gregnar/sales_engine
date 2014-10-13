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

  def invoice_items
    invoices.map { |invoice| invoice.invoice_items }.flatten
  end

  def revenue(arg=nil)
    revenue = BigDecimal.new("0")
    invoice_items.map { |ii|
    revenue += ii.total_cost if ii.invoice.transactions.any?(&:success?)
    }
    revenue
  end

  def invoice_paid
    #select invoice.has_been_paid (transaction success)
  end

  def revenue(date)
    #revenue(date) returns the total revenue for that merchant for a specific invoice date
    #invoice_paid, look for:
    #invoice.created_at (or updated_at) needs to be a date
    #invoice.transactions
  end

  def favorite_customer
    #customer who has conducted the most successful transactions
  end

  def customers_with_pending_invoices
  end

end
