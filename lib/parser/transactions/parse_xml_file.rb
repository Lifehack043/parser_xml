module Transactions
    class ParseXmlFile
      include Dry::Transaction(container: Parser)
  
      step :parse_config, with: 'operations.fetch_config'
      step :parse_xml_file, with: 'operations.parse_xml_file'
      step :store_database, with: 'operations.store_database'
    end
  end