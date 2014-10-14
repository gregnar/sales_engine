class Item
  attr_reader :id,
              :name,
              :description,
              :unit_price,
              :merchant_id,
              :created_at,
              :updated_at,
              :repository

  def initialize(data, repository)
    @id           = data[:id]
    @name         = data[:name]
    @description  = data[:description]
    @unit_price   = BigDecimal.new(data[:unit_price]) / 100
    @merchant_id  = data[:merchant_id]
    @created_at   = data[:created_at]
    @updated_at   = data[:updated_at]
    @repository   = repository
  end

  # def total_sold
  #   successes = invoice_items.reject_if {|ii| ii.invoice.}
  #   invoice_items.inject(0) {|sum, ii| sum + ii.quantity}
  # end

  def revenue
    # revenue = BigDecimal.new("0")
    successful_invoice_items.inject(0) do |sum, ii|
      sum + ii.total_cost
    end
  end

  def invoice_items
    @invoice_items ||= repository.find_invoice_items_by_item_id(self.id)
  end

  def successful_invoice_items
    @successful_invoice_items ||= invoice_items.select { |ii| ii.invoice.successful? }
  end

  def merchant
    @merchant ||= repository.find_merchant_by_id(self.merchant_id)
  end

  def best_day
    invoice_items.inject { |sum, ii| Date.parse(ii.invoice.created_at).to_date }
  end
end
