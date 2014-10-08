require_relative 'csv_parser'
require_relative 'customer_repository'
require_relative 'invoice_item_repository'
require_relative 'invoice_repository'
require_relative 'item_repository'
require_relative 'merchant_repository'
require_relative 'transaction_repository'

class SalesEngine

  def initialize
    @parser = CSVParser.new
    @customer_repository = CustomerRepository.new(self)
    @invoice_item_repository = InvoiceItemRepository.new(self)
    @invoice_repository = InvoiceRepository.new(self)
    @item_repository = ItemRepository.new(self)
    @merchant_repository = MerchantRepository.new(self)
    @transaction_repository = TransactionRepository.new(self)
  end

  def distribute
  end

  def find_items_by_id(id)
    item_repository.find_all_by_merchant_id(id)
  end

  def find_invoices_by_id(invoice_id)
    invoice_repository.find_all_by_merchant_id(invoice_id)
  end

  #invoice relationships go here

  def find_invoice_by_invoice_id(invoice_id)
    invoice_repository.find_by_id(invoice_id)
  end

  def find_item_by_item_id(item_id)
    item_repository.find_by_id(item_id)
  end

  def find_merchant_by_id(merchant_id)
    merchant_repository.find_by_id(merchant_id)
  end

  def find_invoice_items(item_id)
    invoice_item_repository.find_all_by_item_id(item_id)
  end

end
