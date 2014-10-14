class Invoice
  attr_reader :id,
              :repository,
              :customer_id,
              :merchant_id,
              :status,
              :created_at,
              :updated_at

  def initialize(data, repository)
    @id           = data[:id]
    @customer_id  = data[:customer_id]
    @merchant_id  = data[:merchant_id]
    @status       = data[:status]
    @created_at   = data[:created_at]
    @updated_at   = data[:updated_at]
    @repository   = repository
  end

  def transactions
    @transactions  ||= repository.find_transaction_by_id(self.id)
  end

  def successful?
    transactions.any?(&:success?)
  end

  def invoice_items
    @invoice_items ||= repository.find_invoice_items_by_invoice_id(self.id)
  end

  def items
    @items         ||= invoice_items.map { |ii| ii.item }
  end

  def customer
    @customer      ||= repository.find_customer_by_id(self.customer_id)
  end

  def merchant
    @merchant      ||= repository.find_merchant_by_id(self.merchant_id)
  end

end
