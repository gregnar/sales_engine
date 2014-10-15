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

  def revenue
    successful_invoice_items.inject(0) do |sum, ii|
      sum + ii.total_cost
    end
  end

  def number_sold
    successful_invoice_items.inject(0) {|sum, ii| sum + ii.quantity}
  end

  def number_sold_by_day
    dates.map do |date|
      good_iis = invoice_items_by_date(date)
      good_iis.inject(0) { |sum, ii| sum + ii.quantity }
    end
  end

  def invoice_items_by_date(date)
    successful_invoice_items.select {|ii| ii.invoice.created_at == date}
  end

  def dates
    dates = successful_invoice_items.map {|ii| ii.invoice.created_at}.uniq
  end

  def invoice_items
    @invoice_items ||= repository.find_invoice_items_by_item_id(self.id)
  end

  def successful_invoice_items
    @successful_invoice_items ||= find_successful_invoice_items
  end

  def find_successful_invoice_items
    invoice_items.select { |ii| ii.invoice.successful? }
  end

  def merchant
    @merchant ||= repository.find_merchant_by_id(self.merchant_id)
  end

  def best_day
    total_sold_by_day = dates.zip(number_sold_by_day).to_h
    best_day = total_sold_by_day.keys.max_by {|key| total_sold_by_day[key] }
    Date.parse(best_day)
  end
end
