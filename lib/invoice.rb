class Invoice
  attr_reader :id,
              :repository,
              :customer_id,
              :merchant_id,
              :status,
              :created_at,
              :updated_at,
              :items

  def initialize(data, repository)
    @data         = data
    @id           = data[:id]
    @customer_id  = data[:customer_id]
    @merchant_id  = data[:merchant_id]
    @status       = data[:status]
    @created_at   = data[:created_at]
    @updated_at   = data[:updated_at]
    @items        = data[:items] if data.include?(:items)
    @repository   = repository
  end

  def transactions
    @transactions ||= repository.find_transactions_by_id(self.id)
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

  def charge(data)
    new_attrs = {
                  invoice_id: self.id,
                  credit_card_number: data[:credit_card_number],
                  credit_card_expiration_date:
                  data[:credit_card_expiration_date],
                  result: data[:result],
                  created_at: DateTime.now, updated_at: DateTime.now
                  }
    return new_transaction = repository.charge(new_attrs)
    @transactions << new_transaction
  end
end
