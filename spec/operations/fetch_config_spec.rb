require_relative '../spec_helper'

RSpec.describe Parser['operations.fetch_config'] do
    
    context 'with valid params' do
        it 'should return success' do
            result = Parser['operations.fetch_config'].
                (config_file: './spec/examples/valid_config.yml', 
                file_to_parse: './spec/examples/valid_purchase.xml')
            expect(result.success?).to eq(true)
        end
    end
    context 'with unvalid params should return error of ' do
        it 'config file missing' do
            result = Parser['operations.fetch_config'].
                (config_file: 'none', 
                file_to_parse: './spec/examples/valid_purchase.yml')
            expect(result.failure?).to eq(true)
            expect(result.to_s.include?('config file missing')).to eq(true)
        end
        it 'missing parameter' do
            result = Parser['operations.fetch_config'].
            (config_file: './spec/examples/unvalid_config.yml', 
            file_to_parse: './spec/examples/valid_purchase.yml')
            expect(result.failure?).to eq(true)
            expect(result.to_s.include?('is missing')).to eq(true)
        end
    end
end