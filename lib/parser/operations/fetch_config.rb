require 'yaml'

module Operations
  class FetchConfig
    include Dry::Transaction::Operation
    include Import[:logger]

    def call(input)
      return Failure('config file missing') unless File.exist?(input[:config_file])
      config = YAML.load_file(input[:config_file])
      validation_schema = get_validation_schema()
      return Failure(validation_schema.(config).errors.to_h) if validation_schema.(config).errors.options[:failures]
      Success(config: YAML.load_file(input[:config_file]), file_to_parse: input[:file_to_parse])
    end


    private

    def get_validation_schema 
      config_schema = Dry::Schema.Params do
        required(:file_type).filled(:string)
        required(:path_to_root).filled(:array)
        required(:customer).hash do
          required(:full_name).filled(:array)
          required(:reg_num).filled(:array)
          required(:postal_adress).filled(:array)
          required(:legal_adress).filled(:array)
          required(:inn).filled(:array)
          required(:kpp).filled(:array)
          required(:phone).filled(:array)
          required(:email).filled(:array)
        end
        required(:purchase).hash do 
          required(:name).filled(:array)
          required(:create_date_time).filled(:array)
          required(:guid).filled(:array)
        end
        required(:lots).hash do
          required(:price).filled(:array)
        end
        required(:lot_items).hash do
          required(:okpd_code).filled(:array)
          required(:okpd_name).filled(:array)
          required(:okei_code).filled(:array)
          required(:okei_national_code).filled(:array)
          required(:qty).filled(:array)
        end
      end
      config_schema 
    end
  end
end