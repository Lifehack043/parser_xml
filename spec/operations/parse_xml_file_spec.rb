require_relative '../spec_helper'

RSpec.describe Parser['operations.parse_xml_file'] do
    context 'with valid params' do
        it 'should return success' do
            result = Parser['operations.parse_xml_file'].
                (config: YAML.load_file('./spec/examples/valid_config.yml'), 
                file_to_parse: './spec/examples/valid_purchase.xml')
            expect(result.success?).to eq(true)
        end
    end
    context 'with unvalid params should return error of ' do
        it 'missing params' do
            result = Parser['operations.parse_xml_file'].
                (config: YAML.load_file('./spec/examples/valid_config.yml'), 
                file_to_parse: './spec/examples/unvalid_purchase.xml')
            expect(result.failure?).to eq(true)
            expect(result.to_s.include?('must be filled')).to eq(true)
        end
    end
end