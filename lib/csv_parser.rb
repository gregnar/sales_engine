require 'csv'

class CSVParser

  def load_csv(file_name)
    csv = CSV.table(file_name, :header_converters => :symbol, :converters => :all)
  end

end
