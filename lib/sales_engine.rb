require_relative 'csv_parser'
require_relative 'customer_repository'
require_relative 'invoice_item_repository'
require_relative 'invoice_repository'
require_relative 'item_repository'
require_relative 'merchant_repository'
require_relative 'transaction_repository'
require 'bigdecimal'

class SalesEngine

  attr_reader :parser,
              :customer_repository,
              :invoice_item_repository,
              :invoice_repository,
              :item_repository,
              :merchant_repository,
              :transaction_repository,
              :path

  def initialize(path="#{File.join(File.expand_path('../..', __FILE__))}/data")
    @path                     = path
    @customer_repository      = CustomerRepository.new(self, path)
    @invoice_item_repository  = InvoiceItemRepository.new(self, path)
    @invoice_repository       = InvoiceRepository.new(self, path)
    @item_repository          = ItemRepository.new(self, path)
    @merchant_repository      = MerchantRepository.new(self, path)
    @transaction_repository   = TransactionRepository.new(self, path)
  end

  def parsed_csv(path)
    parser.load_csv(path)
  end

  def repository_array
    [customer_repository, invoice_item_repository, invoice_repository,
    item_repository, merchant_repository, transaction_repository]
  end

  def startup
    repository_array.map { |repo| repo.make_repo }
  end

  def distribute
  end

  def find_items_by_id(id)
    item_repository.find_all_by_merchant_id(id)
  end

  def find_invoices_by_merchant_id(merchant_id)
    invoice_repository.find_all_by_merchant_id(merchant_id)
  end

  def find_invoices_by_customer_id(customer_id)
    invoice_repository.find_all_by_customer_id(customer_id)
  end

  def find_transactions_by_invoice_id(invoice_id)
    transaction_repository.find_all_by_invoice_id(invoice_id)
  end

  def find_invoice_items(invoice_id)
    invoice_item_repository.find_all_by_invoice_id(invoice_id)
  end

  def find_invoice_by_invoice_id(invoice_id)
    invoice_repository.find_by_id(invoice_id)
  end

  def find_item_by_id(item_id)
    item_repository.find_by_id(item_id)
  end

  def find_merchant_by_id(merchant_id)
    merchant_repository.find_by_id(merchant_id)
  end

  def find_invoice_items(invoice_id)
    invoice_item_repository.find_all_by_invoice_id(invoice_id)
  end

  def find_invoice_items_by_item_id(item_id)
    invoice_item_repository.find_all_by_item_id(item_id)
  end

  def find_customer_by_id(customer_id)
    customer_repository.find_by_id(customer_id)
  end

  def find_invoice_by_id(invoice_id)
    invoice_repository.find_by_id(invoice_id)
  end

  def new_transaction(new_transaction_attrs)
    transaction_repository.create(new_transaction_attrs)
  end
end

# engine = SalesEngine.new
# engine.startup
# merchant = engine.merchant_repository.repository.sample
# merchant.revenue
