require_relative '../spec_helper'

RSpec.describe Parser['operations.store_database'] do
    let(:valid_purchase) do Parser['operations.parse_xml_file'].
                    (config: YAML.load_file('./spec/examples/valid_config.yml'), 
                    file_to_parse: './spec/examples/valid_purchase.xml') 
    end

    context 'with valid params' do
        it 'should return success' do
            result = Parser['operations.store_database'].(valid_purchase.flatten)
            expect(result.success?).to eq(true)
        end
    end
end