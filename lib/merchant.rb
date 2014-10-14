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

  # def revenue(arg = nil)
  #   # successes = successful_invoice_items
  #   invoice_items.inject(0) do |sum, ii|
  #       sum + ii.total_cost
  #   end
  # end

  def successful_invoice_items
    invoice_items.reject { |ii| ii.invoice.transactions.none?(&:success?) }
  end

  def revenue(date=nil)
    if date
      invoice_items_paid_by_date = invoice_items_paid.select do |ii|
        Date.parse(ii.invoice.created_at).to_date == date
      end
      calculate_revenue(invoice_items_paid_by_date)
    else
      calculate_revenue(invoice_items)
    end
  end

  def calculate_revenue(ii_list)
    revenue = BigDecimal.new("0")
    ii_list.map { |ii|
    revenue += ii.total_cost if ii.invoice.transactions.any?(&:success?)
    }
    revenue
  end

  def invoice_items_paid
    invoice_items.select { |ii| ii.invoice.successful_transactions }
  end

  def customers
   invoices.flat_map(&:customer).uniq
  end

  def favorite_customer
    customers.max_by do |cust|
      cust.successful_transactions_with_merchant(self).count
    end
  end

  def customers_with_pending_invoices
    customers.select{ |cust| cust.pending_transactions_with_merchant?(self) }
  end

  def successful_transactions_with_customer(cust)
    
  end

end
