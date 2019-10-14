require 'active_support/core_ext'
module Operations

  class ParseXmlFile
    include Dry::Transaction::Operation
    include Import[:logger]

    def call(input)
      return Failure('file to parse missing') unless File.exist?(input[:file_to_parse])
      xml = File.open(input[:file_to_parse])
      data = Hash.from_xml(xml)
      formated_purchase = get_formated_purchase(data.dig(*input[:config]['path_to_root']), input[:config])
      validation_schema = get_validation_schema
      return Failure(validation_schema.(formated_purchase).errors.to_h) if validation_schema.(formated_purchase).errors.options[:failures]
      Success(purchase: formated_purchase)
    end

    private

    def get_validation_schema
      purchase_schema = Dry::Schema.Params do
        required(:name).filled(:string)
        required(:create_date_time).filled(:string)
        required(:guid).filled(:string)
        required(:customer_attributes).hash do 
          required(:full_name).filled(:string)
          required(:reg_num).filled(:decimal)
          required(:postal_adress).filled(:string)
          required(:legal_adress).filled(:string)
          required(:inn).filled(:decimal)
          required(:kpp).filled(:decimal)
          required(:phone).filled(:string)
          required(:email).filled(:string)
        end
        required(:lots_attributes).array(:hash) do
          required(:price).filled(:integer)
          required(:lot_items_attributes).array(:hash) do
            required(:okpd_code).filled(:string)
            required(:okpd_name).filled(:string)
            required(:okei_code).filled(:decimal)
            required(:okei_national_code).filled(:string)
            required(:qty).filled(:float)
          end
        end
      end
    end

    def get_formated_purchase purchase, config
      formated_purchase = {
        "customer_attributes" => {},
        "lots_attributes" => []
      }
      config['purchase'].keys.each do |attribute|
        formated_purchase[attribute] = purchase.dig(*config['purchase'][attribute])
      end
      config['customer'].keys.each do |attribute| 
        formated_purchase["customer_attributes"][attribute] = 
        purchase.dig(*config['customer'][attribute])
      end
      lot = {'lot_items_attributes' => [] }
      config['lots'].keys.each do |attribute|
        lot[attribute] = purchase.dig(*config['lots'][attribute])
      end
      formated_purchase["customer_attributes"]
      lot_item = {}
      config['lot_items'].keys.each do |attribute|
        lot_item[attribute] = purchase.dig(*config['lot_items'][attribute])
      end
      lot['lot_items_attributes'].push(lot_item)
      formated_purchase['lots_attributes'].push(lot)
      formated_purchase
    end
  end
end